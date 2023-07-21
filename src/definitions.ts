export interface MediaPickerPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
