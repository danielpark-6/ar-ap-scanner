# Acceptance Criteria (short)

## CSV import
- User uploads CSV file (customers or invoices).
- App previews rows and highlights validation errors.
- User confirms import; system saves valid rows and shows counts (imported, failed).
- Import creates Customer / Invoice / InvoiceItem records.

## Invoice PDF
- Each invoice has a "Download PDF" button.
- PDF contains: invoice number, issue date, due date, billing info, line items, totals, tax, currency.
