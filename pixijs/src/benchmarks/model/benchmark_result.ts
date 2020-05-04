export class BenchmarkResult {
  public constructor(private averageFrameDuration: number, private framesPerSecond: number) {}

  public toString(): string {
    return `{Average Frame Duration: ${this.averageFrameDuration}, Average Fps: ${this.framesPerSecond}}`;
  }
}
