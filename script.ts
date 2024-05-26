import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

async function main() {
    
}

main()
.catch(e => {
    console.error(`Error: ${e.message}`)
})
.finally(async () => {
    await prisma.$disconnect()
})