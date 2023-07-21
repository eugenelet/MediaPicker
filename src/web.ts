import { WebPlugin } from '@capacitor/core';

import type { MediaPickerPlugin } from './definitions';

export class MediaPickerWeb extends WebPlugin implements MediaPickerPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
