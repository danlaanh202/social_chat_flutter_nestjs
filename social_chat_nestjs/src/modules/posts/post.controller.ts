import {
  Controller,
  Get,
  Post,
  Body,
  UseInterceptors,
  UploadedFile,
  Query,
} from '@nestjs/common';
import { PostService } from './post.service';
import { JwtGuards } from 'src/decorator/jwt.guard';
import { FileInterceptor } from '@nestjs/platform-express';

@Controller('post')
export class PostController {
  constructor(private postService: PostService) {}
  @Post('create')
  @JwtGuards()
  @UseInterceptors(FileInterceptor('file'))
  createPost(@UploadedFile() file: Express.Multer.File, @Body() body: any) {
    console.log(file);
    return this.postService.createPost(file, body);
  }

  @Get('get')
  @JwtGuards()
  getPosts(@Query() params: any) {
    return this.postService.getPosts(params.user_id);
  }
  @Get('get_posts_of_id')
  @JwtGuards()
  getPostsOfId(@Query() params: any) {
    return this.postService.getPostsOfId(params.user_id);
  }
}
