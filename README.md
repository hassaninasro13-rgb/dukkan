# Dukkan

## Google Sheets Webhook

To send every new order automatically to Google Sheets:

1. Open https://script.google.com
2. Create a new project.
3. Paste this code:

```javascript
function doPost(e) {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  const data = JSON.parse(e.postData.contents);
  sheet.appendRow([
    data.order_number, data.date, data.name, data.phone,
    data.governorate, data.address, data.product,
    data.size, data.color, data.quantity,
    data.price, data.shipping, data.status
  ]);
  return ContentService.createTextOutput('OK');
}
```

4. Deploy as a Web App.
5. Set `Execute as` to `Me`.
6. Set `Who has access` to `Anyone`.
7. Copy the Web App URL and paste it in `إعدادات المتجر` under `ربط Google Sheets`.
