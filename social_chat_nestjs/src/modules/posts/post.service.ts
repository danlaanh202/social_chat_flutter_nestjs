import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CloudinaryService } from '../cloudinary/cloudinary.service';

@Injectable({})
export class PostService {
  constructor(
    private readonly prismaService: PrismaService,
    private cloudinaryService: CloudinaryService,
  ) {}
  async createPost(file: any, body: any) {
    try {
      const image = await this.cloudinaryService.uploadFile(file);
      const post = await this.prismaService.post.create({
        data: {
          author: {
            connect: {
              id: body.my_id,
            },
          },
          description: body.description || '',
          image_path: image.url,
        },
        include: {
          author: true,
        },
      });
      return { image: image, post: post };
    } catch (error) {
      throw new Error(error);
    }
  }

  async getPosts(my_id: string) {
    try {
      const friends = await this.prismaService.friendRequest.findMany({
        where: {
          OR: [{ requester_id: my_id }, { recipient_id: my_id }],
          status: 'FRIEND',
        },
      });
      const friendIds = friends.map((friend) =>
        friend.requester_id === my_id
          ? friend.recipient_id
          : friend.requester_id,
      );
      const friendPosts = await this.prismaService.post.findMany({
        where: {
          author_id: {
            in: [my_id, ...friendIds],
          },
        },
        include: {
          author: true,
        },
      });
      return friendPosts;
    } catch (error) {
      throw new Error(error);
    }
  }
  async getPostsOfId(my_id: string) {
    try {
      const myPosts = await this.prismaService.post.findMany({
        where: {
          author_id: my_id,
        },
        include: {
          author: true,
        },
      });
      return myPosts;
    } catch (error) {
      throw new Error(error);
    }
  }
}
