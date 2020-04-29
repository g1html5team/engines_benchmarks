export class UrlUtils {
  public static getDimensionsFromQueryParam(queryParams: string): { width: number; height: number } {
    const urlParams = new URLSearchParams(window.location.search);
    let width: number;
    let height: number;

    if (urlParams.has('cw')) {
      width = parseInt(urlParams.get('cw'), 10);
    }

    if (urlParams.has('ch')) {
      height = parseInt(urlParams.get('ch'), 10);
    }

    return { width, height };
  }
}
