<?php include 'functions.php'; ?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mini-chat</title>
    <link rel="stylesheet" href="index.css">
    <script src="https://kit.fontawesome.com/45e38e596f.js" crossorigin="anonymous"></script>
</head>

<body>
    <nav>
        <h1 class="title">Mini-chat</h1>
    </nav>

    <p class="comments-tutorial">
        Message are automatically updated every 4 seconds.<br>
    </p>

    <div class="comments">
        <div class='comments-top'></div>
        <div class='messages'><?= loadComments() ?></div>
        <form id='comments-form'>
            <div class="form-group">
                <input type="text" name="name" id="name" placeholder="Enter your name...">
            </div>
            <div class='form-group'>
                <textarea name='message' id='message' cols='30' rows='10' placeholder='Enter your message...'></textarea>
                <button type='button' class='disabled'>
                    <i class='fas fa-paper-plane'></i>
                </button>
            </div>
        </form>
    </div>

    <h1 class="bonus">Bonus</h1>

    <p class="tutorial">
        You can send a message by pressing <i class="fas fa-paper-plane"></i> or by pressing <kbd>Enter</kbd>.<br>
        You can add a new author by clicking on the <i class="fas fa-plus"></i> button.<br>
        You can remove a author by clicking on the <i class="fas fa-times"></i> button on the top right corner of the
        chat.<br>
        Message are automatically updated every 4 seconds.<br>
    </p>

    <main><?= createChats() ?></main>

    <script src="./index.js"></script>
</body>
