SVG_NS = 'http://www.w3.org/2000/svg'

class Shape
  el: null

  constructor: (type, attributes) ->
    @el = document.createElementNS SVG_NS, type

    for attribute, value of attributes || {}
      @attr attribute, value

  attr: (attribute, value) ->
    @el.setAttributeNS null, attribute, value

class SVG
  el: null

  constructor: (attributes) ->
    @el = document.createElementNS SVG_NS, 'svg'

    for attribute, value of attributes || {}
      @attr attribute, value

  attr: Shape::attr

  create: (type, attributes) ->
    shape = new Shape type, attributes
    @el.appendChild shape.el
    shape

module.exports = SVG
