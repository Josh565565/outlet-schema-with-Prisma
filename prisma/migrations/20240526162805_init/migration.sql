-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('USER', 'STORE', 'SALEREP', 'ADMIN');

-- CreateEnum
CREATE TYPE "ProductType" AS ENUM ('TYPE1', 'TYPE2');

-- CreateTable
CREATE TABLE "Account" (
    "id" BIGSERIAL NOT NULL,
    "type" "AccountType" NOT NULL,
    "users" BIGINT,
    "store" BIGINT,
    "saleRep" BIGINT,
    "admin" BIGINT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Customer" (
    "id" BIGSERIAL NOT NULL,
    "cardNumber" TEXT NOT NULL,
    "exp" TEXT NOT NULL,
    "nameOnCard" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "county" TEXT NOT NULL,
    "accountId" BIGINT NOT NULL,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" BIGSERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "type" "ProductType" NOT NULL,
    "amount" TEXT NOT NULL,
    "accountId" BIGINT NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" BIGSERIAL NOT NULL,
    "firstName" TEXT NOT NULL DEFAULT 'Joshua',
    "lastName" TEXT NOT NULL DEFAULT 'Okwor',
    "email" TEXT NOT NULL DEFAULT 'smartcash565@gmail.com',
    "password" TEXT NOT NULL DEFAULT 'okechukwu',
    "isFirstLogin" BOOLEAN NOT NULL DEFAULT true,
    "lastLogin" TIMESTAMP(3),
    "isActivated" BOOLEAN NOT NULL DEFAULT true,
    "isTermsAccepted" BOOLEAN NOT NULL DEFAULT true,
    "accountId" BIGINT NOT NULL DEFAULT 1,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Stores" (
    "id" BIGSERIAL NOT NULL,
    "nameOfStore" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "socialMediaHandles" JSONB NOT NULL,
    "domainName" TEXT NOT NULL,
    "profilePicture" TEXT NOT NULL,
    "accountId" BIGINT NOT NULL,
    "isRegistered" BOOLEAN NOT NULL,
    "businessRegistrationNumber" TEXT NOT NULL,

    CONSTRAINT "Stores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" BIGSERIAL NOT NULL,
    "storeId" BIGINT NOT NULL,
    "amount" TEXT NOT NULL,
    "completed" BOOLEAN NOT NULL,
    "productId" BIGINT NOT NULL,
    "transactionId" BIGINT NOT NULL,
    "initiatedDate" TIMESTAMP(3) NOT NULL,
    "completedDate" TIMESTAMP(3),
    "customerId" BIGINT NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" BIGSERIAL NOT NULL,
    "orderId" BIGINT NOT NULL,
    "mediumOfPayment" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "paymentReferenceCode" TEXT NOT NULL,
    "paymentCallbackLink" TEXT NOT NULL,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Newsletter" (
    "id" BIGSERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL,

    CONSTRAINT "Newsletter_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Stores_nameOfStore_key" ON "Stores"("nameOfStore");

-- CreateIndex
CREATE UNIQUE INDEX "Stores_domainName_key" ON "Stores"("domainName");

-- CreateIndex
CREATE UNIQUE INDEX "Newsletter_email_key" ON "Newsletter"("email");

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stores" ADD CONSTRAINT "Stores_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES "Stores"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "Customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
