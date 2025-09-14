function addParameter() {
    const parametersDiv = document.getElementById('parameters');
    const newRow = document.createElement('div');
    newRow.className = 'parameter-row';
    newRow.innerHTML = `
        <input type="text" class="param-key" placeholder="Key">
        <input type="text" class="param-value" placeholder="Value">
        <button class="btn-remove" onclick="removeParameter(this)">削除</button>
    `;
    parametersDiv.appendChild(newRow);
}

function removeParameter(button) {
    const row = button.parentElement;
    if (document.querySelectorAll('.parameter-row').length > 1) {
        row.remove();
    }
}

function getParameters() {
    const params = {};
    const rows = document.querySelectorAll('.parameter-row');
    rows.forEach(row => {
        const key = row.querySelector('.param-key').value.trim();
        const value = row.querySelector('.param-value').value.trim();
        if (key) {
            params[key] = value;
        }
    });
    return params;
}

function testAPI() {
    const endpoint = document.getElementById('endpoint').value.trim();
    const method = document.getElementById('method').value;
    const parameters = getParameters();

    if (!endpoint) {
        alert('エンドポイントを入力してください');
        return;
    }

    const testButton = document.querySelector('.btn-test');
    testButton.disabled = true;
    document.getElementById('loading').style.display = 'block';
    document.getElementById('response').textContent = '';

    fetch('/api/test', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            endpoint: endpoint,
            method: method,
            parameters: parameters
        })
    })
    .then(response => response.json())
    .then(result => {
        displayResponse(result);
    })
    .catch(error => {
        displayError(error);
    })
    .finally(() => {
        testButton.disabled = false;
        document.getElementById('loading').style.display = 'none';
    });
}

function displayResponse(result) {
    const responseDiv = document.getElementById('response');

    if (!result.success) {
        responseDiv.innerHTML = `<span class="error">エラー: ${result.error}</span>`;
    } else {
        let displayText = `ステータスコード: ${result.statusCode}\n\n`;
        if (result.headers) {
            displayText += `ヘッダー:\n${JSON.stringify(result.headers, null, 2)}\n\n`;
        }
        displayText += `レスポンスボディ:\n${result.body}`;
        responseDiv.textContent = displayText;
    }
}

function displayError(error) {
    document.getElementById('response').innerHTML = `<span class="error">エラー: ${error.message}</span>`;
}