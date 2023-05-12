import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { AuthGuard } from '@nestjs/passport';
import { JwtGuards } from 'src/decorator/jwt.guard';

@Controller('user')
export class UserController {
  constructor(private userService: UserService) {}
  @Get('/')
  @UseGuards(AuthGuard('jwt'))
  getAllUsers() {
    return this.userService.getUsers();
  }

  @Get('/get_all_friends')
  @UseGuards(AuthGuard('jwt'))
  getAllFriends(@Query() params: any) {
    return this.userService.getMyFriends(params.my_id, params.search_query);
  }
  @Get('/search')
  @UseGuards(AuthGuard('jwt'))
  searchUsers(@Query() params: any) {
    return this.userService.searchUsers(params.search_query, params.my_id);
  }

  @Get('/search_received_users')
  @JwtGuards()
  searchReceivedUsers(@Query() params: any) {
    return this.userService.searchReceivedUsers(
      params.search_query,
      params.my_id,
    );
  }
  @Get('/search_sent_users')
  @JwtGuards()
  searchSentUsers(@Query() params: any) {
    return this.userService.searchSentUsers(params.search_query, params.my_id);
  }
  // @Get("/my_user")
  // @JwtGuards()
  // getMyUser(@Query() params: any) {
  //   return this.userService.search
  // }
}
