require \./html.styl
require! <[
  ./html.pug
]>
import
  \gsap : TweenMax
  \simplex-noise : SimplexNoise
  \lodash : {throttle}
  \paper

elem = $ html
$(\body).append elem
cursor = elem._[0]
clsName = cursor.className
clsNameLen = clsName.length
strokeColor = "#000"

clientX = -19
clientY = -19
const innerCursor = $s \.cursor-6du


lastX = 0
lastY = 0
isStuck = false
var group, stuckX, stuckY, fillOuterCursor
const segments = 8
const radius = 10
const canvas = elem._[1]
const strokeWidth = 1

const shapeBound = 40

paper.setup(canvas)


const poly = new paper.Path.RegularPolygon(
  new paper.Point(0, 0),
  segments,
  radius/2
)
poly.strokeColor = strokeColor
poly.strokeWidth = strokeWidth


const initCanvas = ~>

  # we'll need these later for the noisy circle
  const noiseScale = 150 # speed
  const noiseRange = 4 # range of distortion
  isNoisy = false # state

  group := new paper.Group([poly])
  group.applyMatrix = false

  const noise = poly.segments.map(~> new SimplexNoise())
  bigCoordinates = []

  # function for linear interpolation of values
  const lerp = (a, b, n) ~>
    return (1 - n) * a + n * b

  # function to map a value from one range to another range
  const map = (value, in_min, in_max, out_min, out_max) ~>
    return (
      ((value - in_min) * (out_max - out_min)) / (in_max - in_min) + out_min
    )

  # the draw loop of Paper.js 
  # (60fps with requestAnimationFrame under the hood)
  paper.view.onFrame = (event) !~>
    if isStuck
      x = stuckX
      y = stuckY
    else
      x = clientX
      y = clientY
    lastX := lerp lastX, x, 0.2
    lastY := lerp lastY, y, 0.2
    group.position = new paper.Point lastX, lastY
    width = poly.bounds.width
    if isStuck
      if width < shapeBound
        poly.scale 1.08
    else
      if width > radius
        if isNoisy
          poly.segments.forEach (segment, i) !~>
            segment.point.set bigCoordinates[i].0, bigCoordinates[i].1
          isNoisy := false
          bigCoordinates := []
        poly.scale 0.92

    if isStuck and width >= shapeBound
      isNoisy := true
      if bigCoordinates.length is 0
        poly.segments.forEach (
          (segment, i) !~>
            bigCoordinates[i] = [segment.point.x, segment.point.y]
        )
      poly.segments.forEach ((segment, i) !~>
        noiseX = noise[i].noise2D event.count / noiseScale, 0
        noiseY = noise[i].noise2D event.count / noiseScale, 1
        distortionX = map noiseX, -1, 1, -noiseRange, noiseRange
        distortionY = map noiseY, -1, 1, -noiseRange, noiseRange
        newX = bigCoordinates[i].0 + distortionX
        newY = bigCoordinates[i].1 + distortionY
        segment.point.set newX, newY
      )
    poly.smooth!

initCanvas()

COLOR = new Set(['A',"BUTTON"])

const initCursor = ~>
  document.addEventListener(
    \mousemove
    (e) !~>
      clientX := e.clientX
      clientY := e.clientY
      if isStuck
        return
      name = cursor.className
      tagName = e.target.tagName
      if COLOR.has(tagName)
          s = " "+tagName
          if not name.endsWith(s)
            cursor.className = clsName+s
            poly.strokeColor = "rgba(0,0,0,0)"
          return
      if name.length != clsNameLen
        cursor.className = clsName
        poly.strokeColor = strokeColor
  )

  const render = ~>
    TweenMax.set(
      innerCursor
      * x: clientX
        y: clientY
    )
    requestAnimationFrame(render)
  requestAnimationFrame(render)

initCursor()

do !~>
  var x,y
  count=0
  setInterval(
    !~>
      if isStuck
        return
      if x == clientX and y == clientY
        if count == 6
          cursor.className = clsName+" H"
          poly.strokeColor = "rgba(0,0,0,0)"
          return
        count+=1
      else
        x := clientX
        y := clientY
        count:=0
    500
  )

_LI = []
var NOW
mouseleave = \mouseleave

customElements.define 'x-ico', ``class extends HTMLElement {
constructor() {
  super()
  _LI.push(this);
  this.addEventListener('mouseenter', e => {
    const box = this.getBoundingClientRect();
    stuckX = Math.round(box.left + box.width / 2);
    stuckY = Math.round(box.top + box.height / 2);
    isStuck = true
    poly.strokeColor = '#f50'
    cursor.className = clsName+" I"
    NOW = this
  })

  this.addEventListener(mouseleave, e => {
    cursor.className = clsName
    poly.strokeColor = strokeColor
    isStuck = false
    if(NOW == this) NOW = undefined;
  })
}
}``


body = document.body
(new MutationObserver(
  throttle(
    (mutationsList, observer)!~>
      li = []
      for i in _LI
        if body.contains i
          li.push i
        else
          if i==NOW
            e = document.createEvent(\HTMLEvents)
            e.initEvent mouseleave, false, true
            i.dispatchEvent e
      _LI := li
    1000
  )
)).observe(
  body
  {
    childList: true
    subtree: true
  }
)
