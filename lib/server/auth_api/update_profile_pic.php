<?php
include 'dbconnect.php';
header('Content-Type: application/json');

function sendResponse($message, $status = 400) {
    http_response_code($status);
    echo json_encode(['message' => $message]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user_id = $_POST['user_id'];
    $profile_pic = $_POST['profile_pic'];

    if (empty($user_id) || empty($profile_pic)) {
        sendResponse("Missing required fields");
    }

    $sql = "UPDATE tbl_users SET profile_pic = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $profile_pic, $user_id);

    if ($stmt->execute()) {
        sendResponse("Profile picture updated successfully", 200);
    } else {
        sendResponse("Failed to update profile picture");
    }

    $stmt->close();
    $conn->close();
} else {
    sendResponse("Invalid request method", 405);
}
?>
