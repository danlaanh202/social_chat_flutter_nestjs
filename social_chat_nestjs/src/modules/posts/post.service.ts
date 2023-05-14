import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CloudinaryService } from '../cloudinary/cloudinary.service';
@Injectable({})
export class PostService {
  constructor(
    private readonly prismaService: PrismaService,
    private cloudinaryService: CloudinaryService,
  ) {}
  async createPost(body: any) {
    try {
      const image = await this.cloudinaryService.uploadFile(body.image);
      console.log(image);
      // const post = await this.prismaService.post.create({
      //   data: {
      //     author: {
      //       connect: {
      //         id: body.user_id,
      //       },
      //     },
      //     description: body.description,
      //     imagePath: body.image_path,
      //   },
      //   include: {
      //     author: true,
      //   },
      // });
      return image;
    } catch (error) {
      throw new Error(error);
    }
  }
}
