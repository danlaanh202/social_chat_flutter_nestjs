-- AlterTable
ALTER TABLE "chats" ADD COLUMN     "is_last_message_viewed" BOOLEAN;

-- CreateIndex
CREATE INDEX "messages_chat_id_created_at_idx" ON "messages"("chat_id", "created_at");
