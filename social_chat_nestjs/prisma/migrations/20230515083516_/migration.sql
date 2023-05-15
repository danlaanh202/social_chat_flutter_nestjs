/*
  Warnings:

  - You are about to drop the column `imagePath` on the `posts` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "posts" DROP COLUMN "imagePath",
ADD COLUMN     "image_path" TEXT;
