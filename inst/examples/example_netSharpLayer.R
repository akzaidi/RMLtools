
# Use the layer functions to generate individual layer specifications

mxlayer_input(c(13, 13))
mxlayer_input(c(3, 7, 7), name = "pixels")

# Convolution layers automatically compute the output size and padding

mxlayer_conv(NULL, c(2, 2), 
           inputshape = c(13, 13), 
           name = "conv1", 
           inputname = "pixels"
)

mxlayer_conv(NULL, 
           c(2, 2), 
           inputshape = c(13, 13), 
           name = "conv1", 
           inputname = "pixels", 
           stride = c(2, 2)
)

mxlayer_conv(NULL, 
           c(1, 2, 2), 
           inputshape = c(3, 13, 13), 
           name = "conv1", 
           inputname = "pixels", 
           stride = c(1, 2, 2)
)

mxlayer_pool(NULL, 
           c(1, 2, 2), 
           inputshape = c(3, 13, 13), 
           name = "conv1", 
           inputname = "pixels", 
           stride = c(1, 2, 2)
)



# Specify the number of nodes in a fully connected layer

mxlayer_full(NULL, nodes = 100, name = "h3", inputname = "conv")

# Output layer

mxlayer_output(NULL, 6, name = "class", inputname = "h3")


# using magrittr pipes to connect layers ----------------------------------

require(magrittr)

mxlayer_input(c(3, 50, 50), name = "pixels") %>% 
  mxlayer_conv(
    kernelshape = c(1, 5, 5),
    name = "conv1", 
    stride = c(1, 2, 3)
  )

mxlayer_input(c(3, 50, 50), name = "pixels") %>% 
  mxlayer_conv(
    kernelshape = c(1, 5, 5),
    name = "conv1", 
    stride = c(1, 2, 3)
  ) %>% 
  mxlayer_pool(
    kernelshape = c(1, 5, 5),
    name = "conv1", 
    stride = c(1, 2, 3)
  )

mxlayer_norm(NULL, inputshape = c(3, 11, 5), kernelshape = c(1,5,5), name = "rnorm1", inputname = "conv")

mxlayer_input(c(3, 50, 50), name = "pixels") %>% 
  mxlayer_conv(
    kernelshape = c(1, 5, 5),
    name = "conv1", 
    stride = c(1, 2, 3)
  ) %>% 
  mxlayer_norm(
    kernelshape = c(1, 5, 5),
    name = "norm1", 
    stride = c(1, 2, 3),
    alpa = 0.0001,
    beta = 0.75
  )


mxlayer_input(c(3, 50, 50), name = "pixels") %>% 
  mxlayer_conv(
    kernelshape = c(3, 5, 5), 
    name = "conv1", 
    stride = c(1, 2, 2),
    mapcount = 48
  ) %>% 
  mxlayer_conv(
    kernelshape = c(1, 4, 4), 
    stride = c(1, 2, 2),
    name = "conv2"
  ) %>% 
  mxlayer_full(nodes = 100, name = "hid1") %>% 
  mxlayer_full(nodes = 30, name = "hid2") %>% 
  mxlayer_output(nodes = 6, name = "class")




