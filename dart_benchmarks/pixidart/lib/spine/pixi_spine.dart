// ignore_for_file: constant_identifier_names
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: package_prefixed_library_names

@JS()
library pixi.pixi_spine.js;

import 'package:js/js.dart';
import 'package:pixi/pixi.dart';

import 'func.dart';

/// Type definitions for pixi-spine 1.0.4
/// Project: https://github.com/pixijs/pixi-spine/
/// Definitions by: martijncroezen <https://github.com/pixijs/pixi-typescript>
/// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped
/// <reference path="../pixi.js/pixi.js.d.ts" />

// Module PIXI

// Module spine
@anonymous
@JS()
abstract class Timeline {
  external List<num> get frames;
  external set frames(List<num> v);
  external num getFrameCount();
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@anonymous
@JS()
abstract class Attachment {
  external String get name;
  external set name(String v);
  external num get type;
  external set type(num v);
  external factory Attachment({String name, num type});
}

@JS("PIXI.spine.Animation")
class Animation {
  // @Ignore
  Animation.fakeConstructor$();
  external factory Animation(String name,
      [List<Timeline> timelines, num duration]);
  external void apply(Skeleton skeleton, num lastTime, num time,
      [bool loop, List<Event> events]);
  external void mix(Skeleton skeleton, num lastTime, num time,
      [bool loop, List<dynamic> events, num alpha]);
  external num binarySearch(List<num> values, num target, num step);
  external num binarySearch1(List<num> values, num target);
  external num linearSearch(List<num> values, num target, num step);
  external String get name;
  external set name(String v);
  external List<Timeline> get timelines;
  external set timelines(List<Timeline> v);
  external num get duration;
  external set duration(num v);
}

@JS("PIXI.spine.AnimationState")
class AnimationState {
  // @Ignore
  AnimationState.fakeConstructor$();
  external AnimationStateData get data;
  external set data(AnimationStateData v);
  external List<TrackEntry> get tracks;
  external set tracks(List<TrackEntry> v);
  external List<Event> get events;
  external set events(List<Event> v);
  external VoidFunc1<num> get onStart;
  external set onStart(VoidFunc1<num> v);
  external VoidFunc1<num> get onEnd;
  external set onEnd(VoidFunc1<num> v);
  external VoidFunc2<num, num> get onComplete;
  external set onComplete(VoidFunc2<num, num> v);
  external VoidFunc2<num, Event> get onEvent;
  external set onEvent(VoidFunc2<num, Event> v);
  external num get timeScale;
  external set timeScale(num v);
  external factory AnimationState(AnimationStateData stateData);
  external void update(num delta);
  external void apply(Skeleton skeleton);
  external void clearTracks();
  external void clearTrack(num trackIndex);
  external TrackEntry JS$_expandToIndex(num index);
  external void setCurrent(num index, TrackEntry entry);
  external TrackEntry setAnimationByName(
      num trackIndex, String animationName, bool loop);
  external TrackEntry setAnimation(
      num trackIndex, Animation animation, bool loop);
  external TrackEntry addAnimationByName(
      num trackIndex, String animationName, bool loop, num delay);
  external TrackEntry addAnimation(
      num trackIndex, Animation animation, bool loop, num delay);
  external TrackEntry getCurrent(num trackIndex);
}

@JS("PIXI.spine.Spine")
class Spine extends Container {
  // @Ignore
  external factory Spine(dynamic spineData);
  external static Spine fromAtlas(String resourceName);
  external void update(num dt);
  external void autoUpdateTransform();
  external Sprite createSprite(Slot slot, Attachment attachment);
  external createMesh(slot, attachment);
  external dynamic get spineData;
  external set spineData(dynamic v);
  external Skeleton get skeleton;
  external set skeleton(Skeleton v);
  external AnimationStateData get stateData;
  external set stateData(AnimationStateData v);
  external AnimationState get state;
  external set state(AnimationState v);
  external List<Container> get slotContainers;
  external set slotContainers(List<Container> v);
  external bool get autoUpdate;
  external set autoUpdate(bool v);
}

@JS("PIXI.spine.AnimationStateData")
class AnimationStateData {
  // @Ignore
  AnimationStateData.fakeConstructor$();
  external factory AnimationStateData(SkeletonData skeletonData);
  external SkeletonData get JS$_skelentonData;
  external set JS$_skelentonData(SkeletonData v);
  external num get animationToMixTime;
  external set animationToMixTime(num v);
  external num get defaultMix;
  external set defaultMix(num v);
  external SkeletonData get skeletonData;
  external set skeletonData(SkeletonData v);
  external void setMixByName(String fromName, String toName, num duration);
  external void setMix(Animation from, Animation to, num duration);
  external num getMix(Animation from, Animation to);
}

@JS("PIXI.spine.AttachmentType")
class AttachmentType {
  // @Ignore
  AttachmentType.fakeConstructor$();
  external static num get region;
  external static set region(num v);
  external static num get boundingbox;
  external static set boundingbox(num v);
  external static num get mesh;
  external static set mesh(num v);
  external static num get skinnedmesh;
  external static set skinnedmesh(num v);
}

@JS("PIXI.spine.Bone")
class Bone {
  // @Ignore
  Bone.fakeConstructor$();
  external BoneData get data;
  external set data(BoneData v);
  external Skeleton get skeleton;
  external set skeleton(Skeleton v);
  external Bone get parent;
  external set parent(Bone v);
  external factory Bone(BoneData boneData, Skeleton skeleton, Bone parent);
  external num get x;
  external set x(num v);
  external num get y;
  external set y(num v);
  external num get rotation;
  external set rotation(num v);
  external num get rotationIK;
  external set rotationIK(num v);
  external num get scaleX;
  external set scaleX(num v);
  external num get scaleY;
  external set scaleY(num v);
  external bool get flipX;
  external set flipX(bool v);
  external bool get flipY;
  external set flipY(bool v);
  external num get m00;
  external set m00(num v);
  external num get m01;
  external set m01(num v);
  external num get worldX;
  external set worldX(num v);
  external num get m10;
  external set m10(num v);
  external num get m11;
  external set m11(num v);
  external num get worldY;
  external set worldY(num v);
  external num get worldRotation;
  external set worldRotation(num v);
  external num get worldScaleX;
  external set worldScaleX(num v);
  external num get worldScaleY;
  external set worldScaleY(num v);
  external bool get worldFlipX;
  external set worldFlipX(bool v);
  external bool get worldFlipY;
  external set worldFlipY(bool v);
  external void updateWorldTransform();
  external void setToSetupPose();
  external void worldToLocal(List<num> world);
  external void localToWorld(List<num> local);
}

@JS("PIXI.spine.BoneData")
class BoneData {
  // @Ignore
  BoneData.fakeConstructor$();
  external String get name;
  external set name(String v);
  external Bone get parent;
  external set parent(Bone v);
  external factory BoneData(String name, Bone parent);
  external num get length;
  external set length(num v);
  external num get x;
  external set x(num v);
  external num get y;
  external set y(num v);
  external num get rotation;
  external set rotation(num v);
  external num get scaleX;
  external set scaleX(num v);
  external num get scaleY;
  external set scaleY(num v);
  external bool get inheritScale;
  external set inheritScale(bool v);
  external bool get inheritRotation;
  external set inheritRotation(bool v);
  external bool get flipX;
  external set flipX(bool v);
  external bool get flipY;
  external set flipY(bool v);
}

@JS("PIXI.spine.BoundingBoxAttachment")
class BoundingBoxAttachment implements Attachment {
  // @Ignore
  BoundingBoxAttachment.fakeConstructor$();
  external factory BoundingBoxAttachment(String name);
  external String get name;
  external set name(String v);
  external List<num> get vertices;
  external set vertices(List<num> v);
  external num get type;
  external set type(num v);
  external void computeWorldVertices(
      num x, num y, Bone bone, List<num> worldVertices);
}

@JS("PIXI.spine.ColorTimeline")
class ColorTimeline implements Timeline {
  // @Ignore
  ColorTimeline.fakeConstructor$();
  external factory ColorTimeline(num frameCount);
  external Curves get curves;
  external set curves(Curves v);
  external List<num> get frames;
  external set frames(List<num> v);
  external num get slotIndex;
  external set slotIndex(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, num r, num g, num b, num a);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.Curves")
class Curves {
  // @Ignore
  Curves.fakeConstructor$();
  external factory Curves(List<num> frameCount);
  external List<num> get curves;
  external set curves(List<num> v);
  external void setLinear(num frameIndex);
  external void setStepped(num frameIndex);
  external void setCurve(num frameIndex, num cx1, num cy1, num cx2, num cy2);
  external num getCurvePercent(num frameIndex, num percent);
}

@JS("PIXI.spine.DrawOrderTimeline")
class DrawOrderTimeline implements Timeline {
  // @Ignore
  DrawOrderTimeline.fakeConstructor$();
  external factory DrawOrderTimeline(num frameCount);
  external List<num> get frames;
  external set frames(List<num> v);
  external List<num> get drawOrders;
  external set drawOrders(List<num> v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, List<num> drawOrder);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.Event")
class Event {
  // @Ignore
  Event.fakeConstructor$();
  external factory Event(dynamic data);
  external dynamic get data;
  external set data(dynamic v);
  external num get intValue;
  external set intValue(num v);
  external num get floatValue;
  external set floatValue(num v);
  external String get stringValue;
  external set stringValue(String v);
}

@JS("PIXI.spine.EventData")
class EventData {
  // @Ignore
  EventData.fakeConstructor$();
  external factory EventData(String name);
  external String get name;
  external set name(String v);
  external num get intValue;
  external set intValue(num v);
  external num get floatValue;
  external set floatValue(num v);
  external String get stringValue;
  external set stringValue(String v);
}

@JS("PIXI.spine.EventTimeline")
class EventTimeline implements Timeline {
  // @Ignore
  EventTimeline.fakeConstructor$();
  external factory EventTimeline(num frameCount);
  external List<num> get frames;
  external set frames(List<num> v);
  external List<Event> get events;
  external set events(List<Event> v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, Event event);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.FfdTimeline")
class FfdTimeline implements Timeline {
  // @Ignore
  FfdTimeline.fakeConstructor$();
  external factory FfdTimeline(num frameCount);
  external Curves get curves;
  external set curves(Curves v);
  external List<num> get frames;
  external set frames(List<num> v);
  external List<num> get frameVertices;
  external set frameVertices(List<num> v);
  external num get slotIndex;
  external set slotIndex(num v);
  external num get attachment;
  external set attachment(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, List<num> vertices);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.FlipXTimeline")
class FlipXTimeline implements Timeline {
  // @Ignore
  FlipXTimeline.fakeConstructor$();
  external factory FlipXTimeline(num frameCount);
  external Curves get curves;
  external set curves(Curves v);
  external List<num> get frames;
  external set frames(List<num> v);
  external num get boneIndex;
  external set boneIndex(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, List<num> vertices);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.FlipYTimeline")
class FlipYTimeline implements Timeline {
  // @Ignore
  FlipYTimeline.fakeConstructor$();
  external factory FlipYTimeline(num frameCount);
  external Curves get curves;
  external set curves(Curves v);
  external List<num> get frames;
  external set frames(List<num> v);
  external num get boneIndex;
  external set boneIndex(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, List<num> vertices);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.IkConstraint")
class IkConstraint {
  // @Ignore
  IkConstraint.fakeConstructor$();
  external factory IkConstraint(IkConstraintData data, Skeleton skeleton);
  external IkConstraintData get data;
  external set data(IkConstraintData v);
  external num get mix;
  external set mix(num v);
  external num get bendDirection;
  external set bendDirection(num v);
  external List<Bone> get bones;
  external set bones(List<Bone> v);
  external Bone get target;
  external set target(Bone v);
  external void apply();
  external void apply1(Bone bone, num targetX, num targetY, num alpha);
  external void apply2(Bone parent, Bone child, num targetX, num targetY,
      num bendDirection, num alpha);
}

@JS("PIXI.spine.IkConstraintData")
class IkConstraintData {
  // @Ignore
  IkConstraintData.fakeConstructor$();
  external factory IkConstraintData(String name);
  external String get name;
  external set name(String v);
  external List<Bone> get bones;
  external set bones(List<Bone> v);
  external Bone get target;
  external set target(Bone v);
  external num get bendDirection;
  external set bendDirection(num v);
  external num get mix;
  external set mix(num v);
}

@JS("PIXI.spine.IkConstraintTimeline")
class IkConstraintTimeline implements Timeline {
  // @Ignore
  IkConstraintTimeline.fakeConstructor$();
  external factory IkConstraintTimeline(num frameCount);
  external Curves get curves;
  external set curves(Curves v);
  external List<num> get frames;
  external set frames(List<num> v);
  external num get ikConstraintIndex;
  external set ikConstraintIndex(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, num mix, num bendDirection);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.MeshAttachment")
class MeshAttachment implements Attachment {
  // @Ignore
  MeshAttachment.fakeConstructor$();
  external factory MeshAttachment(String name);
  external String get name;
  external set name(String v);
  external num get type;
  external set type(num v);
  external List<num> get vertices;
  external set vertices(List<num> v);
  external List<num> get uvs;
  external set uvs(List<num> v);
  external List<num> get regionUVs;
  external set regionUVs(List<num> v);
  external List<num> get triangles;
  external set triangles(List<num> v);
  external num get hullLength;
  external set hullLength(num v);
  external num get r;
  external set r(num v);
  external num get g;
  external set g(num v);
  external num get b;
  external set b(num v);
  external num get a;
  external set a(num v);
  external String get path;
  external set path(String v);
  external dynamic get rendererObject;
  external set rendererObject(dynamic v);
  external num get regionU;
  external set regionU(num v);
  external num get regionV;
  external set regionV(num v);
  external num get regionU2;
  external set regionU2(num v);
  external num get regionV2;
  external set regionV2(num v);
  external bool get regionRotate;
  external set regionRotate(bool v);
  external num get regionOffsetX;
  external set regionOffsetX(num v);
  external num get regionOffsetY;
  external set regionOffsetY(num v);
  external num get regionWidth;
  external set regionWidth(num v);
  external num get regionHeight;
  external set regionHeight(num v);
  external num get regionOriginalWidth;
  external set regionOriginalWidth(num v);
  external num get regionOriginalHeight;
  external set regionOriginalHeight(num v);
  external List<num> get edges;
  external set edges(List<num> v);
  external num get width;
  external set width(num v);
  external num get height;
  external set height(num v);
  external void updateUVs();
  external void computeWorldVertices(
      num x, num y, Slot slot, List<num> worldVertices);
}

@JS("PIXI.spine.RegionAttachment")
class RegionAttachment implements Attachment {
  // @Ignore
  RegionAttachment.fakeConstructor$();
  external factory RegionAttachment(String name);
  external String get name;
  external set name(String v);
  external List<num> get offset;
  external set offset(List<num> v);
  external List<num> get uvs;
  external set uvs(List<num> v);
  external num get type;
  external set type(num v);
  external num get x;
  external set x(num v);
  external num get y;
  external set y(num v);
  external num get rotation;
  external set rotation(num v);
  external num get scaleX;
  external set scaleX(num v);
  external num get scaleY;
  external set scaleY(num v);
  external num get width;
  external set width(num v);
  external num get height;
  external set height(num v);
  external num get r;
  external set r(num v);
  external num get g;
  external set g(num v);
  external num get b;
  external set b(num v);
  external num get a;
  external set a(num v);
  external String get path;
  external set path(String v);
  external dynamic get rendererObject;
  external set rendererObject(dynamic v);
  external num get regionOffsetX;
  external set regionOffsetX(num v);
  external num get regionOffsetY;
  external set regionOffsetY(num v);
  external num get regionWidth;
  external set regionWidth(num v);
  external num get regionHeight;
  external set regionHeight(num v);
  external num get regionOriginalWidth;
  external set regionOriginalWidth(num v);
  external num get regionOriginalHeight;
  external set regionOriginalHeight(num v);
  external void updateOffset();
  external void setUVs(num u, num v, num u2, num v2, num rotate);
  external void computeVertices(num x, num y, Bone bone, List<num> vertices);
}

@JS("PIXI.spine.RotateTimeline")
class RotateTimeline implements Timeline {
  // @Ignore
  RotateTimeline.fakeConstructor$();
  external factory RotateTimeline(num frameCount);
  external Curves get curves;
  external set curves(Curves v);
  external List<num> get frames;
  external set frames(List<num> v);
  external num get boneIndex;
  external set boneIndex(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, num mix, num bendDirection);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.ScaleTimeline")
class ScaleTimeline implements Timeline {
  // @Ignore
  ScaleTimeline.fakeConstructor$();
  external factory ScaleTimeline(num frameCount);
  external Curves get curves;
  external set curves(Curves v);
  external List<num> get frames;
  external set frames(List<num> v);
  external num get boneIndex;
  external set boneIndex(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, num mix, num bendDirection);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.Skeleton")
class Skeleton {
  // @Ignore
  Skeleton.fakeConstructor$();
  external factory Skeleton(SkeletonData skeletonData);
  external SkeletonData get data;
  external set data(SkeletonData v);
  external List<Bone> get bones;
  external set bones(List<Bone> v);
  external List<Slot> get slots;
  external set slots(List<Slot> v);
  external List<Slot> get drawOrder;
  external set drawOrder(List<Slot> v);
  external List<IkConstraint> get ikConstraints;
  external set ikConstraints(List<IkConstraint> v);
  external List<List<Bone>> get boneCache;
  external set boneCache(List<List<Bone>> v);
  external num get x;
  external set x(num v);
  external num get y;
  external set y(num v);
  external Skin get skin;
  external set skin(Skin v);
  external num get r;
  external set r(num v);
  external num get g;
  external set g(num v);
  external num get b;
  external set b(num v);
  external num get a;
  external set a(num v);
  external num get time;
  external set time(num v);
  external bool get flipX;
  external set flipX(bool v);
  external bool get flipY;
  external set flipY(bool v);
  external void updateCache();
  external void updateWorldTransform();
  external void setToSetupPose();
  external void setBonesToSetupPose();
  external void setSlotsToSetupPose();
  external Bone getRootBone();
  external Bone findBone(String boneName);
  external num findBoneIndex(String boneName);
  external Slot findSlot(String slotName);
  external num findSlotIndex(String slotName);
  external Skin setSkinByName(String skinName);
  external void setSkin(Skin newSkin);
  external Attachment getAttachmentBySlotName(
      String slotName, String attachmentName);
  external Attachment getAttachmentBySlotIndex(
      num slotIndex, String attachmentName);
  external void setAttachment(String slotName, String attachmentName);
  external IkConstraint findIkConstraint(String ikConstraintName);
  external void update(num delta);
  external void resetDrawOrder();
}

@JS("PIXI.spine.SkeletonBounds")
class SkeletonBounds {
  // @Ignore
  SkeletonBounds.fakeConstructor$();
  external List<Polygon> get polygonPool;
  external set polygonPool(List<Polygon> v);
  external List<Polygon> get polygons;
  external set polygons(List<Polygon> v);
  external List<BoundingBoxAttachment> get boundingBoxes;
  external set boundingBoxes(List<BoundingBoxAttachment> v);
  external num get minX;
  external set minX(num v);
  external num get minY;
  external set minY(num v);
  external num get maxX;
  external set maxX(num v);
  external num get maxY;
  external set maxY(num v);
  external void update(Skeleton skeleton, bool updateAabb);
  external void aabbCompute();
  external void aabbContainsPoint(num x, num y);
  external bool aabbIntersectsSegment(num x1, num y1, num x2, num y2);
  external bool aabbIntersectsSkeleton(SkeletonBounds bounds);
  external BoundingBoxAttachment containsPoint(num x, num y);
  external BoundingBoxAttachment intersectsSegment(
      num x1, num y1, num x2, num y2);
  external bool polygonContainsPoint(Polygon polygon, num x, num y);
  external bool polygonIntersectsSegment(
      Polygon polygon, num x1, num y1, num x2, num y2);
  external Polygon getPolygon(Attachment attachment);
  external num getWidth();
  external num getHeight();
}

@JS("PIXI.spine.SkeletonData")
class SkeletonData {
  // @Ignore
  SkeletonData.fakeConstructor$();
  external List<Bone> get bones;
  external set bones(List<Bone> v);
  external List<Slot> get slots;
  external set slots(List<Slot> v);
  external List<Skin> get skins;
  external set skins(List<Skin> v);
  external List<Event> get events;
  external set events(List<Event> v);
  external List<Animation> get animations;
  external set animations(List<Animation> v);
  external List<IkConstraint> get ikConstraints;
  external set ikConstraints(List<IkConstraint> v);
  external String get name;
  external set name(String v);
  external Skin get defaultSkin;
  external set defaultSkin(Skin v);
  external num get width;
  external set width(num v);
  external num get height;
  external set height(num v);
  external dynamic get version;
  external set version(dynamic v);
  external dynamic get hash;
  external set hash(dynamic v);
  external Bone findBone(String boneName);
  external num findBoneIndex(String boneName);
  external Slot findSlot(String slotName);
  external num findSlotIndex(String slotName);
  external Skin findSkin(String skinName);
  external Event findEvent(String eventName);
  external Animation findAnimation(String animationName);
  external IkConstraint findIkConstraint(String ikConstraintName);
}

@JS("PIXI.spine.SkeletonJsonParser")
class SkeletonJsonParser {
  // @Ignore
  SkeletonJsonParser.fakeConstructor$();
  external factory SkeletonJsonParser(dynamic attachmentLoader);
  external dynamic get attachmentLoader;
  external set attachmentLoader(dynamic v);
  external num get scale;
  external set scale(num v);
  external void readSkeletonData(Bone root, String name);
  external void readAttachment(Skin skin, String name, dynamic map);
  external void readAnimation(
      String name, dynamic map, SkeletonData skeletonData);
  external void readCurve(Timeline timeline, num frameIndex, dynamic valueMap);
  external num toColor(String hexString, String colorIndex);
  external List<num> getFloatArray(dynamic map, String name, num scale);
  external List<num> getIntArray(dynamic map, String name);
}

@JS("PIXI.spine.Skin")
class Skin {
  // @Ignore
  Skin.fakeConstructor$();
  external factory Skin(String name);
  external String get name;
  external set name(String v);
  external List<Attachment> get attachments;
  external set attachments(List<Attachment> v);
  external void addAttachment(
      num slotIndex, String name, Attachment attachment);
  external Attachment getAttachment(num slotIndex, String name);
  external void JS$_attachAll(Skeleton skeleton, Skin oldSkin);
}

@JS("PIXI.spine.SkinnedMeshAttachment")
class SkinnedMeshAttachment implements Attachment {
  // @Ignore
  SkinnedMeshAttachment.fakeConstructor$();
  external factory SkinnedMeshAttachment(String name);
  external String get name;
  external set name(String v);
  external num get type;
  external set type(num v);
  external List<num> get bones;
  external set bones(List<num> v);
  external List<num> get weights;
  external set weights(List<num> v);
  external List<num> get uvs;
  external set uvs(List<num> v);
  external List<num> get regionUVs;
  external set regionUVs(List<num> v);
  external List<num> get triangles;
  external set triangles(List<num> v);
  external num get hullLength;
  external set hullLength(num v);
  external num get r;
  external set r(num v);
  external num get g;
  external set g(num v);
  external num get b;
  external set b(num v);
  external num get a;
  external set a(num v);
  external String get path;
  external set path(String v);
  external dynamic get rendererObject;
  external set rendererObject(dynamic v);
  external num get regionU;
  external set regionU(num v);
  external num get regionV;
  external set regionV(num v);
  external num get regionU2;
  external set regionU2(num v);
  external num get regionV2;
  external set regionV2(num v);
  external bool get regionRotate;
  external set regionRotate(bool v);
  external num get regionOffsetX;
  external set regionOffsetX(num v);
  external num get regionOffsetY;
  external set regionOffsetY(num v);
  external num get regionWidth;
  external set regionWidth(num v);
  external num get regionHeight;
  external set regionHeight(num v);
  external num get regionOriginalWidth;
  external set regionOriginalWidth(num v);
  external num get regionOriginalHeight;
  external set regionOriginalHeight(num v);
  external List<num> get edges;
  external set edges(List<num> v);
  external num get width;
  external set width(num v);
  external num get height;
  external set height(num v);
  external void updateUVs(num u, num v, num u2, num v2, bool rotate);
  external void computeWorldVertices(
      num x, num y, Slot slot, List<num> worldVertices);
}

@JS("PIXI.spine.Slot")
class Slot {
  // @Ignore
  Slot.fakeConstructor$();
  external factory Slot(SlotData slotData, Bone bone);
  external SlotData get data;
  external set data(SlotData v);
  external Bone get bone;
  external set bone(Bone v);
  external num get r;
  external set r(num v);
  external num get g;
  external set g(num v);
  external num get b;
  external set b(num v);
  external num get a;
  external set a(num v);
  external num get JS$_attachmentTime;
  external set JS$_attachmentTime(num v);
  external Attachment get attachment;
  external set attachment(Attachment v);
  external List<num> get attachmentVertices;
  external set attachmentVertices(List<num> v);
  external void setAttachment(Attachment attachment);
  external void setAttachmentTime(num time);
  external num getAttachmentTime();
  external void setToSetupPose();
}

@JS("PIXI.spine.SlotData")
class SlotData {
  // @Ignore
  SlotData.fakeConstructor$();
  external factory SlotData(String name, BoneData boneData);
  external String get name;
  external set name(String v);
  external BoneData get boneData;
  external set boneData(BoneData v);
  external static dynamic
  /*{
                multiply: number;
                screen: number;
                additive: number;
                normal: number;
            }*/
  get PIXI_BLEND_MODE_MAP;
  external static set PIXI_BLEND_MODE_MAP(
      dynamic
      /*{
                multiply: number;
                screen: number;
                additive: number;
                normal: number;
            }*/
      v);
  external num get r;
  external set r(num v);
  external num get g;
  external set g(num v);
  external num get b;
  external set b(num v);
  external num get a;
  external set a(num v);
  external String get attachmentName;
  external set attachmentName(String v);
  external num get blendMode;
  external set blendMode(num v);
}

@JS("PIXI.spine.TrackEntry")
class TrackEntry {
  // @Ignore
  TrackEntry.fakeConstructor$();
  external TrackEntry get next;
  external set next(TrackEntry v);
  external TrackEntry get previous;
  external set previous(TrackEntry v);
  external Animation get animation;
  external set animation(Animation v);
  external bool get loop;
  external set loop(bool v);
  external num get delay;
  external set delay(num v);
  external num get time;
  external set time(num v);
  external num get lastTime;
  external set lastTime(num v);
  external num get endTime;
  external set endTime(num v);
  external num get timeScale;
  external set timeScale(num v);
  external num get mixTime;
  external set mixTime(num v);
  external num get mixDuration;
  external set mixDuration(num v);
  external num get mix;
  external set mix(num v);
  external VoidFunc1<num> get onStart;
  external set onStart(VoidFunc1<num> v);
  external VoidFunc1<num> get onEnd;
  external set onEnd(VoidFunc1<num> v);
  external VoidFunc2<num, num> get onComplete;
  external set onComplete(VoidFunc2<num, num> v);
  external VoidFunc2<num, Event> get onEvent;
  external set onEvent(VoidFunc2<num, Event> v);
}

@JS("PIXI.spine.TranslateTimeline")
class TranslateTimeline implements Timeline {
  // @Ignore
  TranslateTimeline.fakeConstructor$();
  external factory TranslateTimeline(num frameCount);
  external List<Curves> get curves;
  external set curves(List<Curves> v);
  external List<num> get frames;
  external set frames(List<num> v);
  external num get boneIndex;
  external set boneIndex(num v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, num x, num y);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.Atlas")
class Atlas {
  // @Ignore
  Atlas.fakeConstructor$();
  external factory Atlas(String atlasText, String baseUrl, dynamic crossOrigin);
  external List<AtlasPage> get pages;
  external set pages(List<AtlasPage> v);
  external List<AtlasRegion> get regions;
  external set regions(List<AtlasRegion> v);
  external num get texturesLoading;
  external set texturesLoading(num v);
  external AtlasRegion findRegion(String name);
  external void dispose();
  external void updateUVs(AtlasPage page);
  external dynamic
  /*{

                alpha: number;
                intensity: number;
                luminanceAlpha: number;
                rgb565: number;
                rgba4444: number;
                rgb888: number;
                rgba8888: number;

            }*/
  get Format;
  external set Format(
      dynamic
      /*{

                alpha: number;
                intensity: number;
                luminanceAlpha: number;
                rgb565: number;
                rgba4444: number;
                rgb888: number;
                rgba8888: number;

            }*/
      v);
  external dynamic
  /*{

                nearest: number;
                linear: number;
                mipMap: number;
                mipMapNearestNearest: number;
                mipMapLinearNearest: number;
                mipMapNearestLinear: number;
                mipMapLinearLinear: number;

            }*/
  get TextureFilter;
  external set TextureFilter(
      dynamic
      /*{

                nearest: number;
                linear: number;
                mipMap: number;
                mipMapNearestNearest: number;
                mipMapLinearNearest: number;
                mipMapNearestLinear: number;
                mipMapLinearLinear: number;

            }*/
      v);
  external dynamic
  /*{

                mirroredRepeat: number;
                clampToEdge: number;
                repeat: number;

            }*/
  get TextureWrap;
  external set TextureWrap(
      dynamic
      /*{

                mirroredRepeat: number;
                clampToEdge: number;
                repeat: number;

            }*/
      v);
}

@JS("PIXI.spine.AtlasAttachmentParser")
class AtlasAttachmentParser {
  // @Ignore
  AtlasAttachmentParser.fakeConstructor$();
  external factory AtlasAttachmentParser(Atlas atlas);
  external RegionAttachment newRegionAttachment(
      Skin skin, String name, String path);
  external SkinnedMeshAttachment newMeshAttachment(
      Skin skin, String name, String path);
  external SkinnedMeshAttachment newSkinnedMeshAttachment(
      Skin skin, String name, String path);
  external BoundingBoxAttachment newBoundingBoxAttachment(
      Skin skin, String name);
}

@JS("PIXI.spine.AtlasPage")
class AtlasPage {
  // @Ignore
  AtlasPage.fakeConstructor$();
  external String get name;
  external set name(String v);
  external dynamic get format;
  external set format(dynamic v);
  external dynamic get minFilter;
  external set minFilter(dynamic v);
  external dynamic get magFilter;
  external set magFilter(dynamic v);
  external dynamic get uWrap;
  external set uWrap(dynamic v);
  external dynamic get vWrap;
  external set vWrap(dynamic v);
  external dynamic get rendererObject;
  external set rendererObject(dynamic v);
  external num get width;
  external set width(num v);
  external num get height;
  external set height(num v);
}

@JS("PIXI.spine.AtlasReader")
class AtlasReader {
  // @Ignore
  AtlasReader.fakeConstructor$();
  external factory AtlasReader(String text);
  external List<String> get lines;
  external set lines(List<String> v);
  external num get index;
  external set index(num v);
  external String trim(String value);
  external String readLine();
  external String readValue();
  external num readTuple(num tuple);
}

@JS("PIXI.spine.AtlasRegion")
class AtlasRegion {
  // @Ignore
  AtlasRegion.fakeConstructor$();
  external AtlasPage get page;
  external set page(AtlasPage v);
  external String get name;
  external set name(String v);
  external num get x;
  external set x(num v);
  external num get y;
  external set y(num v);
  external num get width;
  external set width(num v);
  external num get height;
  external set height(num v);
  external num get u;
  external set u(num v);
  external num get v;
  external set v(num v);
  external num get u2;
  external set u2(num v);
  external num get v2;
  external set v2(num v);
  external num get offsetX;
  external set offsetX(num v);
  external num get offsetY;
  external set offsetY(num v);
  external num get originalWidth;
  external set originalWidth(num v);
  external num get originalHeight;
  external set originalHeight(num v);
  external num get index;
  external set index(num v);
  external bool get rotate;
  external set rotate(bool v);
  external dynamic get splits;
  external set splits(dynamic v);
  external dynamic get pads;
  external set pads(dynamic v);
}

@JS("PIXI.spine.AttachmentTimeline")
class AttachmentTimeline implements Timeline {
  // @Ignore
  AttachmentTimeline.fakeConstructor$();
  external factory AttachmentTimeline(num frameCount);
  external num get slotIndex;
  external set slotIndex(num v);
  external List<num> get frames;
  external set frames(List<num> v);
  external List<String> get attachmentNames;
  external set attachmentNames(List<String> v);
  external num getFrameCount();
  external void setFrame(num frameIndex, num time, String attachmentName);
  external void apply(Skeleton skeleton, num lastTime, num time,
      List<Event> firedEvents, num alpha);
}

@JS("PIXI.spine.atlasParser")
class atlasParser {
  // @Ignore
  atlasParser.fakeConstructor$();
  external factory atlasParser(dynamic resource, dynamic next);
  external dynamic get AnimCache;
  external set AnimCache(dynamic v);
  external bool get enableCaching;
  external set enableCaching(bool v);
}

// End module spine

// End module PIXI