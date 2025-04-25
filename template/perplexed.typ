#import "@preview/polylux:0.4.0": *
#import "@preview/pinit:0.2.2": *
#import "@preview/physica:0.9.4": *

#let page-numbering-format = {
  align(
    right,
    text(
      size: 12pt,
      fill: color.hsl(0deg, 0%, 50%)
    )[
        #toolbox.slide-number/#toolbox.last-slide-number
    ]
  )
}
#let gradient-text(grad, body) = {
  box(text(fill: grad, body))
}
#let admonition(
  title: none,
  colour: none,
  body
) = {
  block(
    fill: color.lighten(colour, 80%),
    radius: 7pt,
    stack(
      dir: ttb,
      spacing: 5pt,
      block(
        fill: color.lighten(colour, 50%),
        inset: 7pt,
        radius: 7pt,
        width: 100%,
        title
      ),
      block(
        inset: 7pt,
        body
      )
    )
  )
}

#let blue = color.rgb("0073e6")
#let red = color.rgb("ff0040")
#let teal = color.rgb("008080")
#let purple = color.rgb("4a2e9e")
#let green = color.rgb("339966")
#let uds-green = color.rgb("#009647")
#let iq-blue = color.rgb("#009bb4")
#let iq-black = color.rgb("#1c1c1b")

#let perplexed(
  title: none,
  author: none,
  date: none,
  show-progress: false,
  body
) = {
  set page(
    paper: "presentation-16-9",
    margin: .4in,
    footer: page-numbering-format
  )
  set text(font: "IBM Plex Sans", size: 18pt, fill: iq-black)
  show math.equation: set text(font: "IBM Plex Math")
  show heading: it => block(spacing: 2em, text(fill: white, it))

  let progress = context {
    let ratio = here().page()/counter(page).final().at(0)
    block(
      width: 100% * ratio,
      height: 1.05in,
      fill: gradient.linear(uds-green, iq-blue)
    )
  }
  
  set page(
    background: [
      #if show-progress {
        place(
          top,
          progress
        )
      }
      #place(
        top,
        block(
          fill: iq-black,
          width: 100%,
          height: 1in,
          place(right, image("iq-logo-white.svg"))
        )
      )
    ]
  )
  set list(spacing: 1.25em)

  // title slide
  [
    #set align(horizon+center)
    #set page(
      footer: none,
      background: image("title.svg")
    )

    #text(size: 36pt, title)
    
    #text(size: 18pt, author)
    #v(-.25em)
    #text(size: 18pt, date)
  ]
  
  body
}

// Overrides for math
// Show identity and diagonal with 0s by default
#let imat = imat.with(fill:0)
#let dmat = dmat.with(fill:0)
// Upright bold for math
#let ub(item) = {math.upright(math.bold(item))}
// Greek phi and epsilon and variations
#let varphi = math.phi
#let phi = math.phi.alt
#let varepsilon = math.epsilon
#let epsilon = math.epsilon.alt
// Non-variable width hat accent
#let hat(content) = math.accent(content, "\u{302}", size: 10%)
// math.plus.minus shorthand
#let pm = math.plus.minus
#let mp = math.minus.plus
// math.expectationvalue shorthand
#let ev(content) = expectationvalue(content)
// Override of ketbra and braket so that there is no deprecation warning
#let ketbra(arg1, arg2) = [#ket(arg1)#bra(arg2)]

#let lind(smth) = {[#math.cal("D") [#smth]]}
#let micro = math.upright(math.mu)
