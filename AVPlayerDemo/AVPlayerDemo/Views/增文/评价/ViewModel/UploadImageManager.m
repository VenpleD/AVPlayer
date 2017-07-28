//
//  UploadImageManager.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/17.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "UploadImageManager.h"

@implementation UploadImageManager
//+ (void)aaimage:(NSArray <UIImage *> *)images {
    
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                         @"text/html",
//                                                         @"image/jpeg",
//                                                         @"image/png",
//                                                         @"application/octet-stream",
//                                                         @"text/json",
//                                                         nil];
//    
//  
//    
//    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
//    
//    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
//    
////    manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
//    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    //需要上传服务器的参数
////    [parameters setValue:@"64611" forKey:@"supplier_id"];
////    
////    [parameters setValue:@"1016" forKey:@"user_id"];
//    NSString *url = @"http://mobile.pinlehuo.com/api.php?m=MemberOper&a=supplierPicsUpload";
//    /**/
//    
//    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        /*   参数说明：
//         1. fileData:   要上传文件的数据
//         2. name:       负责上传文件的远程服务中接收文件使用的字段名称
//         3. fileName：   要上传文件的文件名
//         4. mimeType：   要上传文件的文件类型
//         
//         提示，在日常开发中，如果要上传图片到服务器，一定记住不要出现文件重名的问题！
//         这个问题，通常涉及到前端程序员和后端程序员的沟通。
//         
//         通常解决此问题，可以使用系统时间作为文件名！
//         */
//        // 1) 取当前系统时间
//        NSDate *date = [NSDate date];
//        // 2) 使用日期格式化工具
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        // 3) 指定日期格式
//        [formatter setDateFormat:@"yyyyMMddHHmmss"];
//        NSString *dateStr = [formatter stringFromDate:date];
//        
//        for (int i = 0; i < images.count; i++) {
//            UIImage *image = images[i];
//            NSData *data = UIImageJPEGRepresentation(image,0.5);
//            // 4) 使用系统时间生成一个文件名
//            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", dateStr,i + 1];
//            [formData appendPartWithFileData:data name:@"environment[]" fileName:fileName mimeType:@"image/jpg"];
//        }
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"进度: %f", uploadProgress.fractionCompleted);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"Success: 成功");
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"Error: %@", error);
//    }];
//    
//    
//    
//    
//  
// 
//    
//    
//    
//
//    
//    
//}
@end
