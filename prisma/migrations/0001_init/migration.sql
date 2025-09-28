-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateTable Customer
CREATE TABLE "public"."Customer" (
  "id" TEXT NOT NULL,
  "email" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "company" TEXT,
  "address_line1" TEXT,
  "address_city" TEXT,
  "address_postcode" TEXT,
  "country" TEXT,
  "phone" TEXT,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable Invoice
CREATE TABLE "public"."Invoice" (
  "id" TEXT NOT NULL,
  "invoiceId" TEXT NOT NULL,
  "customerId" TEXT NOT NULL,
  "dateIssued" TIMESTAMP(3) NOT NULL,
  "dateDue" TIMESTAMP(3) NOT NULL,
  "currency" TEXT NOT NULL,
  "status" TEXT NOT NULL,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "Invoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable InvoiceItem
CREATE TABLE "public"."InvoiceItem" (
  "id" TEXT NOT NULL,
  "invoiceId" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "qty" INTEGER NOT NULL,
  "unitPrice" DOUBLE PRECISION NOT NULL,
  "taxPercent" DOUBLE PRECISION NOT NULL DEFAULT 0,
  CONSTRAINT "InvoiceItem_pkey" PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "Customer_email_key" ON "public"."Customer"("email");
CREATE UNIQUE INDEX "Invoice_invoiceId_key" ON "public"."Invoice"("invoiceId");

-- Foreign keys
ALTER TABLE "public"."Invoice" ADD CONSTRAINT "Invoice_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "public"."Customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "public"."InvoiceItem" ADD CONSTRAINT "InvoiceItem_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "public"."Invoice"("id") ON DELETE RESTRICT ON UPDATE CASCADE;