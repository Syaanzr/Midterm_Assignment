<?php
ob_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: application/json');
include 'dbconnect.php';

$work_id = $_POST['work_id'] ?? null;
$worker_id = $_POST['worker_id'] ?? null;
$submission_text = $_POST['submission_text'] ?? null;

if (!$work_id || !$worker_id || !$submission_text) {
    echo json_encode(['success' => false, 'message' => 'Missing parameters']);
    exit;
}

$query = "INSERT INTO tbl_submissions (work_id, worker_id, submission_text) VALUES (?,?,?)";
$stmt = $conn->prepare($query);
$stmt->bind_param("iis", $work_id, $worker_id, $submission_text);
//$stmt->execute();

if ($stmt->execute()) {
    $updateQuery="UPDATE tbl_works SET status = 'completed' WHERE id = ?";
    $updatestmt = $conn->prepare($updateQuery);
    
    if ($updatestmt === false){
        echo json_encode(['success' => false, 'message' => 'Error submitting task']);
        exit;
    }
    $updatestmt->bind_param("i", $work_id);
    $updatestmt->execute();
    
    echo json_encode(['success' => true, 'message' => 'Submission successfull']);
}

$stmt->close();
$conn->close();
ob_end_flush();
?>