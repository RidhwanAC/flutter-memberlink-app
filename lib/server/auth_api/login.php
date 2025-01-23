<?php
include 'dbconnect.php';
header('Content-Type: application/json');

function validateEmail($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL) && preg_match('/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/', $email);
}

function sendResponse($message, $status = 400, $data = null) {
    http_response_code($status);
    $response = ['message' => $message];
    if ($data !== null) {
        $response['data'] = $data;
    }
    echo json_encode($response);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $login = $_POST['email']; // This can be either email or username
    $password = $_POST['password'];

    if (empty($login) || empty($password)) {
        sendResponse("Please provide all required fields.");
    }

    // Check if the login input is an email or username
    $isEmail = validateEmail($login);
    
    // Prepare the appropriate SQL query based on login type
    if ($isEmail) {
        $sql = "SELECT id, username, email, password FROM tbl_users WHERE email = ?";
    } else {
        $sql = "SELECT id, username, email, password FROM tbl_users WHERE username = ?";
    }

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $login);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        if (password_verify($password, $user['password'])) {
            // Remove password from response data
            unset($user['password']);
            
            sendResponse("Login successful!", 200, [
                'user' => $user
            ]);
        } else {
            sendResponse("Invalid password.");
        }
    } else {
        if ($isEmail) {
            sendResponse("No user found with this email.");
        } else {
            sendResponse("No user found with this username.");
        }
    }

    $stmt->close();
    $conn->close();
} else {
    sendResponse("Invalid request method.", 405);
}
?>
