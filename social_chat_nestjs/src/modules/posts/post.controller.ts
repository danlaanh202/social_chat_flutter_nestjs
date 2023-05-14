import { Controller, Get, Post, Body } from '@nestjs/common';
import { PostService } from './post.service';
import { JwtGuards } from 'src/decorator/jwt.guard';

@Controller('post')
export class PostController {
  constructor(private postService: PostService) {}
  @Post('/create')
  @JwtGuards()
  createPost(@Body() body: any) {
    return this.postService.createPost(body);
  }
}
