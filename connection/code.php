  <?php require_once('admin.php');?>
  <?php require_once('session.php');?>
  <?php $action=$_GET['action'];?>



<?php
  //// for current date and time
  if ($action=='date_time'){
	?>
 <?php echo date("h:i:s") ?> <span> <?php echo date("A") ?> </span>
<?php
  }
?>


  <?php
  //// for login
  if ($action=='login'){/////Check 1 if action is log in
      $userquery = mysqli_query ($conn,"SELECT * FROM `staff_tab` WHERE email_address = '$logusername'  AND `password`='$logpassword' AND status_id='A'") or die ('cannot select user');
      $user_count=mysqli_num_rows($userquery);
      if ($user_count>0){
        $userdata=mysqli_fetch_array($userquery);
        $user_id=$userdata['user_id'];
        $role_id=$userdata['role_id'];
        
        
      //// get user id into session
      $_SESSION['user_id'] = $user_id;
      $loguser_id = $_SESSION['user_id'];

      mysqli_query($conn, "UPDATE `staff_tab` SET last_login_date=NOW() WHERE `user_id` = '$user_id'")or die ('cannot update');
 
        
      if ($role_id=='A'){/////Check 2 - if role is A
	?>
		    <script>
        window.parent(location="../admin-portal");
        </script>
  <?php
      }/////end check 2
      else{//////////else for check 2
  ?>
        <script>
        window.parent(location="../staff-portal");
        </script>
  <?php
      }//////////end else for check 2
    }else{//////////else for check 2 
	    session_destroy();
	?>
		<script>
        alert('INVALID LOGIN CREDIENTAILS!!!');
        window.parent(location="../index.php");
        </script>
  <?php
    
      }////////////end else for check 1
    }///// action end if
?>













<?php
  //// for reset password
  if ($action=='reset_password'){//// checkk 001
        ////check if email address is present in the database 
        $emailquery = mysqli_query ($conn,"SELECT 'email_address' FROM `staff_tab` WHERE email_address='$reset_email'") or die ('cannot select staff');
        $emailcount=mysqli_num_rows($emailquery);
        if ($emailcount<1){ /// check 3
          ?>
          <script>
          alert('USER NOT AVAILABLE!!!');
          window.parent(location="../index.php");
          </script>
          <?php
        }else{//////perfrom otp action
          $otp=rand(111111, 999999);

      
          $to = $reset_email;
          $subject = "RESET PASSWORD OTP, SALES BAY, ADMINISTRATOR";
          $txt = "Your OTP is $otp";
          $headers = "From: support@salesbay.com" . "\r\n" .
          "CC: support@salesbay.com";
          mail($to,$subject,$txt,$headers);
      
            mysqli_query($conn,"UPDATE staff_tab SET `otp`='$otp' where `email_address` = '$reset_email'");
            ?>
            <script>
            
            window.parent(location="../reset-password.php?reset_email=<?php echo $reset_email?>");
            </script>
            <?php
          }/// end check 003
        }
?>






<?php
  //// for reset password
  if ($action=='otp_reset'){//// check 001
    $reset_email=$_GET['reset_email'];


     //// check if the otp in the database is equal to the one in the current otp
     $userquery = mysqli_query ($conn,"SELECT otp FROM `staff_tab` WHERE email_address = '$reset_email'") or die ('cannot select user');
     $user_count=mysqli_num_rows($userquery);
     if ($user_count>0){
       $userdata=mysqli_fetch_array($userquery);
       $db_otp=$userdata['otp'];
     }////end check 3
       if($otp!=$db_otp){  //// check 2
     ?>
       <script>
           alert('INCORRECT OTP!!!, PLEASE VERIFY FROM YOUR MAIL...');
           window.history.back();
         </script>

   
    <?php
    }////end check 2
    else{//check 3
      if($password!=$confirm_password){  //// check 2
        ?>
          <script>
              alert('PASSWORD NOT MATCH!');
              window.history.back();
              </script>
  <?php
      } /////// End check 3
         else{
            mysqli_query($conn,"UPDATE staff_tab SET `password`='$password' where `email_address` = '$reset_email'");
            ?>
            <script>
            window.parent(location="../reset-password-successful.php");
            </script>
            <?php
          }/// end check 003
        }
      }
 
?>







































  <?php
  //// for staff registration
  if ($action=='staff_reg'){ /// check 1
          if($password!=$confirm_password){  //// check 2
        ?>
          <script>
              alert('PASSWORD NOT MATCH!');
              window.history.back();
              </script>
      <?php
          }else{//else check 2
        ////check if phone number is present in the database 
        $emailquery = mysqli_query ($conn,"SELECT 'email_address' FROM `staff_tab` WHERE email_address='$email_address'") or die ('cannot select email');
        $emailcount=mysqli_num_rows($emailquery);
        if ($emailcount>0){ /// check 3
          ?>
      <script>
      alert('THE EMAIL ADDRESS HAS ALREADY BEEN TAKEN!!!');
      window.parent(location="../index.php");
      </script>
      <?php
        }else{///else check 3
          /// get current master_value from matser_tab for staff
          $idquery = mysqli_query ($conn,"SELECT * FROM `master_tab` WHERE master_id = 'STAFF' FOR UPDATE");
          $idsel=mysqli_fetch_array($idquery);
          $master_value=$idsel['master_value'];
          $master_value=$master_value+1;

          ////// get user_id
          $reg_user_id='STAFF'.$master_value; 
		 $_SESSION['reg_user_id']=$reg_user_id;
                  ///// update master_value in master_tab for staff
          mysqli_query ($conn,"UPDATE `master_tab` SET master_value='$master_value' WHERE master_id = 'STAFF'");

 
          				
  	////// upload image for user registration
        $allowedExts = array("jpg", "jpeg", "JPEG", "JPG", "gif", "png");
        $passport = $_FILES["passport"]["name"]; 
        $extension = pathinfo($_FILES["passport"]["name"], PATHINFO_EXTENSION);
       if (in_array($extension, $allowedExts)){				 //////////array 
        $passport = date('Ymdis').$user_id.$passport;
        move_uploaded_file($_FILES["passport"]["tmp_name"], "../admin-portal/upload/user-passport/".$passport);
        }//////////////////end array
		

          ////// insert into staff_tab
          mysqli_query($conn,"INSERT INTO staff_tab VALUES ('', '$reg_user_id', '$first_name', '$last_name', '$address', '$phone_number', '$email_address', '$passport', '$status_id','$role_id','$password','','', NOW())") or die ('Cannot insert');
          ?>
            <script>
            window.parent(location="../admin-portal/registration-successful.php");  
            </script>
          <?php
            }///end check 3
            }///end check 2
          }/// end check 1
?>






<?php
  //// for change password
  if ($action=='change_password'){//// checkk 001
      $userquery = mysqli_query ($conn,"SELECT * FROM `staff_tab` WHERE `user_id` = '$loguser_id'") or die ('cannot select user');
        $userdata=mysqli_fetch_array($userquery);
        $db_password=$userdata['password'];
      
        if ($old_password!= $db_password){//// check 002
          ?>
          <script>
          alert('INCORRECT OLD PASSWORD!!!');
          window.parent(location="../admin-portal/change-password.php");
          </script>
          <?php
        }else{//else check 002
          if ($new_password!=$confirm_new_password){/// check 003
            ?>
          <script>
          alert('NEW PASSWORD AND CONFIRM PASSWORD IS NOT THE SAME');
          window.parent(location="../admin-portal/change-password.php");
          </script>
          <?php
          }else{//else check 003
            mysqli_query($conn,"UPDATE staff_tab SET `password`='$new_password' where `user_id` = '$loguser_id'");
            ?>
            <script>
            
            window.parent(location="../admin-portal/change-password-successful.php");
            </script>
            <?php
          }/// end check 003
        }/// end check 002
      }/// end check 001
?>






<?php
  //// for logout
  if ($action=='logout'){
	session_destroy();
	?>
		    <script>
        window.parent(location="../index.php");
        </script>
<?php
  }
?>







<?php
///// for user profile update
if ($action=='update_users_profile'){
  $user_profile_id=$_GET['user_profile_id'];

  $passport = $_FILES["passport"]["name"]; 
  ////////// check if email address is present in the database
  $emailquery = mysqli_query($conn, "SELECT email_address FROM staff_tab WHERE email_address = '$email_address' AND `user_id`!='$user_profile_id'") or die('cannot select');
  $emailcount = mysqli_num_rows($emailquery);

if($emailcount>0){
  ?>
    <script>
          alert('THE EMAIL HAD ALREADY BEEN USED');
          window.parent(location="../admin-portal/user-profile.php?user_id=<?php echo $user_profile_id?>");
          </script>
    <?php
}else{/////
  if($passport==''){
    mysqli_query ($conn,"UPDATE `staff_tab` SET first_name='$first_name', last_name='$last_name', phone_number='$phone_number', `address`='$address', email_address='$email_address', status_id='$status_id',  role_id='$role_id' WHERE `user_id` = '$user_profile_id'")or die ('cannot update');
  }else {//////////////////////////////

          $allowedExts = array("jpg", "jpeg", "JPEG", "JPG", "gif", "png");
          $extension = pathinfo($_FILES["passport"]["name"], PATHINFO_EXTENSION);
         if (in_array($extension, $allowedExts)){				 //////////array 
          $passport = date('Ymdis').$user_id.$passport;
          move_uploaded_file($_FILES["passport"]["tmp_name"], "../admin-portal/upload/user-passport/".$passport);
          }//////////////////end array






mysqli_query($conn, "UPDATE `staff_tab` SET first_name='$first_name', last_name='$last_name', phone_number='$phone_number', `address`='$address', email_address='$email_address', status_id='$status_id',  role_id='$role_id', passport='$passport' WHERE `user_id` = '$user_profile_id'")or die ('cannot update');
  }

  
    ?>
        <script>
          alert('UPDATE COMPLETE!!!');
          window.parent(location="../admin-portal/user-profile.php?user_id=<?php echo $user_profile_id?>");
          </script>
    <?php
  }
}
?>













<?php
  //// for category registration
  if ($action=='category_reg'){ /// check 1
          
        ////check if category name is present in the database 
        $categorynamequery = mysqli_query ($conn,"SELECT 'category_name' FROM `category_tab` WHERE category_name='$category_name'") or die ('cannot select category');
        $categorynamecount=mysqli_num_rows($categoryquery);

        if ($emailcount>0){ /// check 3
          ?>
      <script>
      alert('THE CATEGORY HAS ALREADY BEEN REGISTERED!!!');
      window.parent(location="../add-category.php");
      </script>
      <?php
        }else{///else check 3
          /// get current master_value from matser_tab for category
          $categoryquery = mysqli_query ($conn,"SELECT * FROM `master_tab` WHERE master_id = 'CATEGORY' FOR UPDATE");
          $categorysel=mysqli_fetch_array($categoryquery);
          $master_value=$categorysel['master_value'];
          $master_value=$master_value+1;

          ////// get category_id
          $category_id='CATEGORY'.$master_value; 

          //// get category id into session
          $_SESSION['category_id'] = $category_id;         

          ///// update master_value in master_tab for category
          mysqli_query ($conn,"UPDATE `master_tab` SET master_value='$master_value' WHERE master_id = 'CATEGORY'");

          ////// insert into category_tab
          mysqli_query($conn,"INSERT INTO category_tab VALUES ('', '$category_id', '$category_name', NOW())") or die ('Cannot insert');
          ?>
            <script>
            window.parent(location="../admin-portal/category.php");  
            </script>
          <?php
            }///end check 3
            }///end check 2
        
?>






<?php
///// for category profile update
if ($action=='update_category_profile'){

///// update category details in category tab
  mysqli_query ($conn,"UPDATE `category_tab` SET category_name='$category_name' WHERE `category_id` = '$category_id'");
    ?>
        <script>
          alert('UPDATE COMPLETE!!!');
          window.parent(location="../admin-portal/category-profile.php?category_id=<?php echo $category_id?>");
          </script>
    <?php
    }
?>













<?php
  //// for product registration
  if ($action=='product_reg'){ /// check 1
          
          $productquery = mysqli_query ($conn,"SELECT * FROM `master_tab` WHERE master_id = 'PRODUCT' FOR UPDATE");
          $productsel=mysqli_fetch_array($productquery);
          $master_value=$productsel['master_value'];
          $master_value=$master_value+1;

          ////// get product
          $product_id='PRODUCT'.$master_value; 

          //// get product id into session
          $_SESSION['product_id'] = $product_id;
          
          ///// update master_value in master_tab for category
          mysqli_query ($conn,"UPDATE `master_tab` SET master_value='$master_value' WHERE master_id = 'PRODUCT'");

          ////// upload picture for product registration 

          $allowedExts = array("jpg", "jpeg", "JPEG", "JPG", "gif", "png");
          $product_picture = $_FILES["product_picture"]["name"]; 
          $extension = pathinfo($_FILES["product_picture"]["name"], PATHINFO_EXTENSION);
         if (in_array($extension, $allowedExts)){				 //////////array 
          $product_picture = date('Ymdis').$product_id.$product_picture;
          move_uploaded_file($_FILES["product_picture"]["tmp_name"], "../admin-portal/upload/product-picture/".$product_picture);
          }//////////////////end array

          ////// insert into category_tab
          mysqli_query($conn,"INSERT INTO product_tab VALUES ('', '$product_category_name', '$product_id', '$product_name', '$product_details', '$product_price', '$product_status', '$product_picture', NOW())") or die ('Cannot insert');
          ?>
            <script>
            window.parent(location="../admin-portal/product-category.php");  
            </script>
          <?php
            }///end check 3        
?>





<?php
///// for product profile update
$product_id=$_GET['product_id'];
if ($action=='update_product_profile'){
$product_picture = $_FILES["product_picture"]["name"]; 

 if($product_picture=='') {
   
///// update product details in product tab if no new picture is needed
mysqli_query ($conn,"UPDATE `product_tab` SET product_name='$product_name', product_details='$product_details', product_price='$product_price',  product_status='$product_status' WHERE `product_id` = '$product_id'");
}else{////////// 


    $allowedExts = array("jpg", "jpeg", "JPEG", "JPG", "gif", "png");
    $extension = pathinfo($_FILES["product_picture"]["name"], PATHINFO_EXTENSION);
    if (in_array($extension, $allowedExts)){				 //////////array 
    $product_picture = date('Ymdis').$product_id.$product_picture;
          move_uploaded_file($_FILES["product_picture"]["tmp_name"], "../admin-portal/upload/product-picture/".$product_picture);
          }//////////////////end array




///// update product details in product tab if no new picture is needed
mysqli_query ($conn,"UPDATE `product_tab` SET product_name='$product_name', product_details='$product_details', product_price='$product_price' , product_status='$product_status', `product_picture`='$product_picture' WHERE `product_id` = '$product_id'");

 
    }
    ?>
        <script>
          alert('UPDATE COMPLETE!!!');
          window.parent(location="../admin-portal/product-profile.php?category_id=<?php echo $product_pro_category_id?>&product_id=<?php echo $product_id?>");
          </script>
    <?php
    }
?>


















<?php
  //// for add stock
    if ($action=='add_stock'){ /// check 1
         
          /// get current master_value from master_tab for stock
          $idquery = mysqli_query ($conn,"SELECT * FROM `master_tab` WHERE master_id = 'LOAD_STOCK' FOR UPDATE");
          $idsel=mysqli_fetch_array($idquery);
          $master_value=$idsel['master_value'];
          $master_value=$master_value+1;

          ////// get stock id
          $stock_id='LOAD_STOCK'.$master_value; 


            //// get stock id into session
            $_SESSION['stock_id'] = $stock_id;    

          ///// update master_value in master_tab for stock
          mysqli_query ($conn,"UPDATE `master_tab` SET master_value='$master_value' WHERE master_id = 'LOAD_STOCK'");

          ////// insert into load_stock_tab
          mysqli_query($conn,"INSERT INTO load_stock_tab VALUES ('', '$stock_id', '$voucher_id', '$denomination_id', '$stock_quantity', '$loguser_id', NOW())") or die ('Cannot insert');
          ?>
            <script>
            window.parent(location="../admin-portal/view-stock.php?voucher_id=<?php echo $voucher_id?>");  
            </script>
          <?php
            }///end check 3
       
    
?>



<?php
///// for stock profile update
if ($action=='update_stock'){
  $stock_id=$_GET['ls_id'];
///// update stock details in load stock tab
  mysqli_query ($conn,"UPDATE `load_stock_tab` SET voucher_id='$voucher_id', denomination_id='$denomination_id', qty='$stock_quantity', staff_id='$loguser_id' WHERE ls_id = '$stock_id'") or die('cannot update');
    ?>
        <script>
          alert('UPDATE COMPLETE!!!');
          window.parent(location="../admin-portal/stock-details.php?ls_id=<?php echo $stock_id?>");
          </script>
    <?php
    }
?>






<?php
///// for denomination profile update
if ($action=='update_denomination'){
  $vd_id=$_GET['vd_id'];
///// update stock details in load stock tab
  mysqli_query ($conn,"UPDATE `voucher_denomination_tab` SET voucher_id='$voucher_id', denomination_id='$denomination_id', unit_price='$stock_price', staff_id='$loguser_id' WHERE vd_id = '$vd_id'") or die('cannot update');
    ?>
        <script>
          alert('UPDATE COMPLETE!!!');
          window.parent(location="../admin-portal/denomination-details.php?vd_id=<?php echo $vd_id?>");
          </script>
    <?php
    }
?>

















<?php
///// for stock profile update
if ($action=='update_product_stock'){
  $load_product_id=$_GET['lp_id'];
///// update stock details in load stock tab
  mysqli_query ($conn,"UPDATE `load_product_tab` SET quantity='$load_product_quantity', staff_id='$loguser_id' WHERE lp_id = '$load_product_id'") or die('cannot update');
    ?>
        <script>
          alert('UPDATE COMPLETE!!!');
          window.parent(location="../admin-portal/load-product-details.php?lp_id=<?php echo $load_product_id?>");
          </script>
    <?php
    }
?>









<?php
  //// for add denomination
    if ($action=='add_denomination'){ /// check 1
         
          /// get current master_value from master_tab for stock
          $idquery = mysqli_query ($conn,"SELECT * FROM `master_tab` WHERE master_id = 'VOUCHER_DENOMINATION' FOR UPDATE");
          $idsel=mysqli_fetch_array($idquery);
          $master_value=$idsel['master_value'];
          $master_value=$master_value+1;

          ////// get stock id
          $vd_id='VOUCHER_DENOMINATION'.$master_value; 


            //// get voucher denimination id into session
            $_SESSION['vd_id'] = $vd_id;    

          ///// update master_value in master_tab for stock
          mysqli_query ($conn,"UPDATE `master_tab` SET master_value='$master_value' WHERE master_id = 'VOUCHER_DENOMINATION'");

          ////// insert into load_stock_tab
          mysqli_query($conn,"INSERT INTO voucher_denomination_tab VALUES ('', '$vd_id', '$voucher_id', '$denomination_id', '$stock_price', '$loguser_id', NOW())") or die ('Cannot insert');
          ?>
            <script>
            window.parent(location="../admin-portal/voucher-denomination.php"); 
            </script>
          <?php
            }///end check 3
       
    
?>












<?php
  //// for loading product
    if ($action=='load_product'){ /// check 1
         $product_id=$_GET['product_id'];
		$category_id=$_GET['category_id'];

         /// get current master_value from master_tab for stock
         $idquery = mysqli_query ($conn,"SELECT * FROM `master_tab` WHERE master_id = 'LOAD_PRODUCT' FOR UPDATE");
         $idsel=mysqli_fetch_array($idquery);
         $master_value=$idsel['master_value'];
         $master_value=$master_value+1;

         ////// get stock id
         $lp_id='LOAD_PRODUCT'.$master_value; 


           //// get lp id into session
          $_SESSION['lp_id'] = $lp_id; 
        
          ////// insert into load_product_tab
          mysqli_query($conn,"INSERT INTO load_product_tab VALUES ('', '$lp_id', '$product_id', '$product_quantity', '$loguser_id', NOW())") or die ('Cannot insert to load product');
          ?>
            <script>
            window.parent(location="../admin-portal/view-products.php?category_id=<?php echo $category_id?>");  
            </script>
          <?php
            }///end check 1
       
    
?>

