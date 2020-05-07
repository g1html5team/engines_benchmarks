export interface BenchmarkConfig {
  target: string;
  userAgent: string;
  serverIp: string;
  serverPort: string;
  userName: string;
  device: string;
  runDuration: string;
  canvasWidth: string;
  canvasHeight: string;
  children: string;
  labels: string;
  filters: string;
  masks: string;
  blend: string;
  gpu: string;
  atlas: string;
  flipbook: string;
  particles: string;
  renderTexture: string;
  shader: string;
  spine: string;
  visibility: string;
  zindex: string;
  stagexl?: string;
  stagexl_canvas?: string;
  ng1n?: string;
  pixi?: string;
  pixi_typescript_external?: string;
}