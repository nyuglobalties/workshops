install.packages("hexSticker")
library(hexSticker)

imgurl <- "/Users/michaelfive/Desktop/R Directory/Git learning/mrautomatr-manual/images/icon1.jpeg"
sticker(imgurl, package="mrautomatr", p_size=7, h_fill = "white",
        p_color = "purple3", h_color = "purple3",
        s_x=1, s_y=.75, s_width=.5,
        filename="/Users/michaelfive/Desktop/R Directory/Git learning/mrautomatr-manual/images/Hexicon.png",
        dpi = 3000)
