import { WebPlugin } from '@capacitor/core';

import type { MediaPickerPlugin } from './definitions';

export class MediaPickerWeb extends WebPlugin implements MediaPickerPlugin {
  async getMedia() : Promise<{ results: any[] }> {
    // console.log('getMedia', options);
    return { results: [] };
  }
  // async echo(options: { value: string }): Promise<{ value: string }> {
  //   console.log('ECHO', options);
  //   return options;
  // }
}
