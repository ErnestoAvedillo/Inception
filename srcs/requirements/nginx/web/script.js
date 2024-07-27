document.getElementById('clickMeButton').addEventListener('click', function() {
    alert('Button clicked!');
});


document.getElementById('clickMeButton1').addEventListener('click', function() {
    
    window.open("/srv/www/wordpress/index.php", "_blank");

});

document.getElementById('clickMeButton2').addEventListener('click', function() {
    window.open("/srv/www/wordpress/wp-admin/about.php", "_blank");

});
