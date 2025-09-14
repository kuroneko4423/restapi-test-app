function doGet() {
  return HtmlService.createTemplateFromFile('index')
      .evaluate()
      .setTitle('REST API テスター')
      .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL);
}

function include(filename) {
  return HtmlService.createHtmlOutputFromFile(filename).getContent();
}

function makeAPIRequest(endpoint, method, parameters) {
  try {
    let url = endpoint;
    let options = {
      'method': method,
      'muteHttpExceptions': true,
      'headers': {
        'Accept': 'application/json'
      }
    };

    if (method === 'GET') {
      const queryParams = Object.keys(parameters)
        .filter(key => parameters[key])
        .map(key => encodeURIComponent(key) + '=' + encodeURIComponent(parameters[key]))
        .join('&');

      if (queryParams) {
        url += (url.includes('?') ? '&' : '?') + queryParams;
      }
    } else {
      if (Object.keys(parameters).length > 0) {
        options.headers['Content-Type'] = 'application/json';
        options.payload = JSON.stringify(parameters);
      }
    }

    const response = UrlFetchApp.fetch(url, options);

    const responseCode = response.getResponseCode();
    const responseText = response.getContentText();
    const headers = response.getAllHeaders();

    let formattedBody = responseText;
    try {
      const jsonResponse = JSON.parse(responseText);
      formattedBody = JSON.stringify(jsonResponse, null, 2);
    } catch (e) {
    }

    return {
      statusCode: responseCode,
      headers: headers,
      body: formattedBody
    };

  } catch (error) {
    return {
      error: error.toString()
    };
  }
}