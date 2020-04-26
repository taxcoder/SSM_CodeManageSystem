import com.tx.pojo.UploadFile;
import com.tx.service.uploadfile.UploadFileService;
import com.tx.service.uploadfile.UploadFileServiceImpl;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 */
@Component
public class UserTest {
    @Test
    public void test(){
        UploadFileService uploadFileService = new UploadFileServiceImpl();
//        int user1 = uploadFileService.queryCount(null);
//        List<UploadFile> uploadFiles = uploadFileService.queryAllPages("admin","EE",0,5);
//        System.out.println(user1);
//        for (UploadFile uploadFile : uploadFiles) {
//            System.out.println(uploadFile);
//        }
    }
}
