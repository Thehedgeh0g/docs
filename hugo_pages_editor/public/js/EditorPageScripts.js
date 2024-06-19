document.getElementById('markdown-input').addEventListener('input', function () {
    const input = this.value;
    document.getElementById('markdown-content').innerHTML = marked.parse(input);
});

window.addEventListener("DOMContentLoaded", function (event) {
    const input = document.getElementById('markdown-input').value;
    document.getElementById('markdown-content').innerHTML = marked.parse(input);
});

function save() {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', "/api/save");
    xhr.addEventListener('load', () => {
        if (xhr.status === 200)
        {
            document.location.href = 'http://localhost:1313/' + document.getElementById('markdown-path').value
        }
    });
    let data = {
        content: document.getElementById('markdown-input').value,
        path: document.getElementById('markdown-path').value,
        originalPath: document.getElementById('original-path').value
    }
    xhr.send(JSON.stringify(data));
}