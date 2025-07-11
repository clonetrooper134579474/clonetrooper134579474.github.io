<?php
header("Content-Type: video/flv");
header('Content-Length: ' . filesize('video.flv'));
readfile('video.flv');
?>
