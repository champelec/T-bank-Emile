document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    form.addEventListener("submit", function() {
        document.body.innerHTML = "<h1>Перенаправление...</h1><p>Подождите, пожалуйста, мы вас перенаправим...</p>";
    });
});