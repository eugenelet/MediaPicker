export interface MediaPickerPlugin {
  getMedia(): Promise<{ results: any[] }>;
  // echo(options: { value: string }): Promise<{ value: string }>;
}
