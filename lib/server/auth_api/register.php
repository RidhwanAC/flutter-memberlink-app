<?php
include 'dbconnect.php';
header('Content-Type: application/json');

function validateUsername($username) {
    return preg_match('/^[a-zA-Z0-9]{4,16}$/', $username);
}

function validatePassword($password) {
    return preg_match('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,18}$/', $password);
}

function validateEmail($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL) && preg_match('/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/', $email);
}

function sendResponse($message, $status = 400) {
    http_response_code($status);
    echo json_encode(['message' => $message]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    if (!validateUsername($username)) {
        sendResponse("Invalid username. Must be 4-16 characters long and contain only letters and numbers.");
    }

    if (!validateEmail($email)) {
        sendResponse("Invalid email format.");
    }

    if (!validatePassword($password)) {
        sendResponse("Invalid password. Must be 6-18 characters long, with at least one uppercase letter, one lowercase letter, and one number.");
    }

    if ($password !== $confirm_password) {
        sendResponse("Passwords do not match.");
    }

    $sql = "SELECT id FROM tbl_users WHERE username = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();
    if ($stmt->num_rows > 0) {
        $stmt->close();
        sendResponse("Username already exists.");
    }
    $stmt->close();

    $sql = "SELECT id FROM tbl_users WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();
    if ($stmt->num_rows > 0) {
        $stmt->close();
        sendResponse("Email already exists.");
    }
    $stmt->close();

    $hashed_password = password_hash($password, PASSWORD_BCRYPT);

    $sql = "INSERT INTO tbl_users (username, email, password) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sss", $username, $email, $hashed_password);

    if ($stmt->execute()) {
        sendResponse("Registration successful!", 200);
    } else {
        sendResponse("Registration failed: " . $stmt->error, 500);
    }

    $stmt->close();
    $conn->close();
}
?>
