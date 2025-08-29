#!/bin/bash
yum update
yum install httpd -y
systemctl enable httpd
systemctl start httpd
systemctl status httpd

cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Good Job!</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f4f8; 
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center; 
            justify-content: center;
            min-height: 100vh;
        }

        .congratulations-block {
            width: 90%; 
            max-width: 450px; 
            background: linear-gradient(135deg, #4a90e2, #6ab7f9);
            border-radius: 15px 15px 0 0; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-weight: bold;
            font-size: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            margin-bottom: 0; 
        }

        .photo-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 0 0 15px 15px; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            max-width: 450px;
            width: 90%;
            text-align: center;
            margin-top: 0; 
        }

        .celebration-container {
            width: 100%;
            height: 175px;
            border-radius: 10px;
            border: 2px solid #ddd;
            background: linear-gradient(45deg, #4a90e2, #6ab7f9, #2c5aa0, #7cc0fa, #4a90e2);
            background-size: 400% 400%;
            animation: gradientShift 4s ease infinite;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .server-text {
            margin-top: 1rem;
            padding: 0.8rem;
            background: linear-gradient(135deg, #4a90e2, #6ab7f9);
            color: #ecf0f1;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.9rem;
            text-align: center;
            border: 1px solid #4a90e2;
        }
    </style>
</head>
<body>
    <div class="congratulations-block">Congratulations!</div>
    <div class="photo-card">
        <div class="celebration-container"></div>
        <div class="server-text">
            Connected to Server 1
        </div>
    </div>
</body>
</html>
EOF
