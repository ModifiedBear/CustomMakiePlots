using CairoMakie

let

  x = LinRange(-1.5, 1.5, 100)
  y = LinRange(-1.5, 1.5, 100)
  k = 3
  z = [sin(k*x^2-y)*cos(k*y^2 - x) for x in x, y in y]

  scale = 2.0
  size_inches = (3, 3)
  size_pt = 72 .* size_inches .* scale
  
  fig = Figure(figure_padding=0,theme=theme_latexfonts(),resolution= size_pt, fontsize=12*scale)
  ax = Axis(fig[1,1])
  ax.xtickalign=1; 
  ax.ytickalign=1


  ax.yreversed=true
  ax.xaxisposition= :bottom
  ax.xticksmirrored = true
  
  ax.yticksmirrored = true
  ax.xgridvisible=false; ax.ygridvisible=false
  perc = 0.03
  xpad = perc * (maximum(x) - minimum(x))
  ypad = perc * (maximum(y) - minimum(y))
  xpad = max(xpad,ypad)
  ypad = xpad

  ax.limits=(minimum(x)-xpad, maximum(x)+xpad, minimum(y)-ypad, maximum(y)+ypad)
  # ax.xticks = 0:400:1200; ax.yticks = 0:400:1200
  
  hm=heatmap!(ax, x,y, real(z), colormap=:vikO, interpolate=true, colorrange=(-1,1))
  # hm=contourf!(ax, x,y, real(z), colormap=:vikO, interpolate=true, colorrange=(-1,1))
  cb=Colorbar(fig[0,1], hm, vertical=false,width = @lift Fixed($(pixelarea(ax.scene)).widths[1]))
  cb.flipaxis=true
  ax.aspect=DataAspect()
  # rowsize!(fig.layout, 1, Aspect(1, 1))
  # rowsize!(fig.layout, 1, ax.scene.px_area[].widths[1])
  ax.xlabel="Sample"; ax.ylabel="Relative amount /%"
  save("figtest.png", fig, px_per_unit=2)
  fig
end
