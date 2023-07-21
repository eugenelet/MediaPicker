import { registerPlugin } from '@capacitor/core';

import type { MediaPickerPlugin } from './definitions';

const MediaPicker = registerPlugin<MediaPickerPlugin>('MediaPicker', {
  web: () => import('./web').then(m => new m.MediaPickerWeb()),
});

export * from './definitions';
export { MediaPicker };
