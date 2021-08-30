<?php require_once("../connection/admin.php")?>
<?php require_once("../connection/session.php")?>
<?php require_once("../connection/query.php")?>
<?php require_once("../connection/staff-validation.php")?>

<?php $product_id=$_GET['product_id'];?>
   

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<?php require_once ("reference.php")?>
<title>Product Sold Report History- IVSM</title>
</head>
<body>

<?php require_once ("navigation.php")?>


<div class="body-div">
	<?php require_once ("alert.php")?>
    <?php require_once ("header.php")?>
        
    <div class="page-name-div">
        <div class="page-name">
            <h1><i class="fa fa-history"> </i> Product Sold Report History</h1>  
        </div>
    </div>
        
    <div class="date-history-div">
    <form method="post" enctype="multipart/form-data" action="product-sold-report-history-search-result.php?product_id=<?php echo $product_id?>">   
        <div class="date-div">
        FROM:
        <input id="" name="date_from" type="date" class="text-field"  placeholder="" title="PICK A DATE" value="" required>
        TO:
        <input id="" name="date_to" type="date" class="text-field" placeholder="" title="PICK A DATE" value="" required>
        <button  title="Search"><i class="fa fa-search"> </i> Search</button>
        </div>
      </form>
    </div>

    <div class="table-div">
<table  class="list-table">
    <tr class="title">
        <td width="10%">SN</td>
        <td width="14%">ORDER ID</td>
        <td width="22%">STAFF</td>
        <td width="15%">QUANTITY</td>
        <td width="17%">DATE</td>
        <td width="13%">ACTION</td>
    </tr>
    <?php
  
    $loadproductquery = mysqli_query ($conn,"SELECT * FROM `cart_tab` WHERE product_id='$product_id' AND order_status_id='S'") or die ('cannot select load product tab');
    $count=0;
	while($loadproductdata=mysqli_fetch_array($loadproductquery)){
        $count++;
    $order_id=$loadproductdata['order_id'];
    $staff_id=$loadproductdata['staff_id'];
	$quantity=$loadproductdata['cart_qty'];
	$date_entered=$loadproductdata['date_entered'];
		///// for staff name
        $staffquery = mysqli_query($conn,"SELECT * FROM `staff_tab` WHERE `user_id` = '$staff_id'") or die ('cannot select staff');
		$staffdata=mysqli_fetch_array($staffquery);
		$staff_first_name=$staffdata['first_name'];
		$staff_last_name=$staffdata['last_name'];
		$staff_full_name="$staff_first_name $staff_last_name";
		
    
?>

    <tr>
      <td><?php echo $count;?></td>
      <td><?php echo $order_id;?></td>
      <td><?php echo $staff_full_name;?></td>
      <td><?php echo $quantity;?></td>
      <td><?php echo $date_entered;?></td>
      <td> 
      <a href="order-details.php?order_id=<?php echo $order_id?>">
      <button  class="action-btn" title="View Order Details"><i class="fa fa-eye"> </i></button>
      </a>
      </td>
    </tr>
        <?php }?>
    <tr class="title">
        <td width="10%">SN</td>
        <td width="14%">ORDER ID</td>
        <td width="22%">STAFF</td>
        <td width="15%">QUANTITY</td>
        <td width="17%">DATE</td>
        <td width="13%">ACTION</td>
    </tr>

</table>
<div>
</div>

</body>
</html>