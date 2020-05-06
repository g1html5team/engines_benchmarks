// window.onload = init();
//
// function create_frame_observer() {
//     if (window.PerformanceObserver === undefined) return;
//
//     // Register the performance observer
//     var observe_frame = new PerformanceObserver(function(list) {
//         // Log the frame entries
//         var perfEntries = list.getEntriesByType("frame");
//         for (var i=0; i < perfEntries.length; i++) {
//             console.log("OBS #1: [" + i + "] = " + perfEntries[i].name);
//         }
//     });
//     // Only observe 'frame' events
//     observe_frame.observe({entryTypes: ['frame']});
// }
//
// function init () {
//     window.requestAnimationFrame(test());
// }
// var i = 0
// test()
// {
//     console.log(i);
//     ++i:
// }