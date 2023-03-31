# projeto-de-cyber


# disclaimer

The Client and the Server configuration are just a exemple



![projeto](https://user-images.githubusercontent.com/114146685/229098640-73d59b25-d4aa-490c-8496-a0c42026f42b.png)



| vpc       | sub                                    | ip                                                        | 
|:---------:|:--------------------------------------:|:---------------------------------------------------------:|
| PDL-VPC   | public-1 <br> private-1 <br> private-2 | 172.21.0.0/24 <br> 172.21.1.0/24 <br> 172.21.2.0/24       |
| LIS-VPC   | puclic-1 <br> private-1 <br> private-2 | 192.168.0.0/26 <br> 192.168.0.64/26 <br> 192.168.0.128/26 |

| pc         | ip                                                        |  
|:----------:|:---------------------------------------------------------:|
| lis-srv    | 192.168.0.10/26 <br> 192.168.0.80/26                      |
| pdl-srv    | 172.21.0.100/24 <br> 172.21.1.100/24 <br> 172.21.2.100/24 |
| inside-lis | 192.168.0.81/26                                           | 
| inside-pdl | 172.21.1.101/24                                           |
| dmz-pdl    | 172.21.2.101/24                                           |
