#include <SDL2/SDL.h>
#include <SDL_rect.h>
#include <SDL_render.h>
#include <SDL_video.h>
#include <iostream>

int main() { 
    std::cout << "Hello World!" << std::endl; 

    SDL_Init(SDL_INIT_VIDEO);

    SDL_Window *window;
    SDL_Renderer *renderer;
    SDL_CreateWindowAndRenderer(300, 300, 0, &window, &renderer);
    
    SDL_SetRenderDrawColor(renderer, 0xFF, 0x80, 0x00, 0x00);
    SDL_Rect rect = {.x = 10, .y = 10, .w = 150, .h =100};

    SDL_RenderFillRect(renderer, &rect);

    SDL_RenderPresent(renderer);

    // TODO: Cleanup

}
