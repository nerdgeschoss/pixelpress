require 'bundler/setup'
require 'pixelpress'


repetitions = 10000

html_content = <<-HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Large HTML File</title>
    <style>
        /* Add some inline CSS here if needed */
    </style>
</head>
<body>
    #{'<h1>Hello, World!</h1>' * repetitions}
    <!-- The string 'Hello, World!' will be repeated the specified number of times -->
</body>
</html>
HTML


Pixelpress::WeasyPrintRenderer.new.render(html_content)