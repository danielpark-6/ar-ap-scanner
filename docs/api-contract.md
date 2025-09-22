# API Contract (minimal)

## POST /api/import/csv
- Request: multipart form with file field ile.
- Response:
  - 200 OK { imported: number, failed: number, errors: [ { row: n, message: '...' } ] }

## POST /api/invoices
- Request body: JSON invoice payload
- Response: 201 Created with saved invoice object
