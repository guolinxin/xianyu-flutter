import 'package:flutter/material.dart';
import '../config/HttpMethod.dart';
/// 明星在闲鱼



class HomeStar extends StatefulWidget {
  HomeStar({Key key}) : super(key: key);

  _HomeStarState createState() => _HomeStarState();
}

class _HomeStarState extends State<HomeStar> {
  @override
  Widget build(BuildContext context) {
        // 白色背景容器
    return FutureBuilder(

      // 请求分类数据
      future: getHomeCategoryStarData(),

      // 成功之后会指向 下面方法
      builder: (context,snapshot){

        // 如果有数据会返回Container页面
        if (snapshot.hasData){
         Map starData =  (snapshot.data).cast();
         print('aaaaaaaaa      $starData');
         List topList = starData['array'];
          print('bbbbbb      $topList');
          Map bottomData = starData['star'];
          print('cccccc      $bottomData');
          return  Stack(
              children: <Widget>[
               
               Container(
                  // 设置高度
                height: 200,
                // 装饰
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.white),
               ),
               Container(
                 height: 150,
                 margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                   color: Colors.white),
                 child: GridView.count(
                   crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.5,
                   children: topList.map((item){
                     return _gridViewItem(context,item);
                   }).toList(),
                 ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 150),
                 
                  child: _starViewItem(context,bottomData),
                ),
               
              ],
  
          );
        } else {
          // 没有数据返回一个占位的视图
         return Container(
                // 设置高度
                height: 200,
                // 间距
                margin: EdgeInsets.all(10),
                // 装饰
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        '还没有获取到数据',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.orange
                        ),
                        ),
                    )
                  ],
                )
              );
        }
      },
      
    );
  }
}


 // 单个分类视图
  Widget _gridViewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        /// 点击对应的item
        print(item['title']);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Colors.grey[200]),right: BorderSide(width: 1,color: item["key"]  == ""  ?Colors.grey[200]: Colors.white))
        ),
        child: Row(
        
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Container(
            padding: EdgeInsets.all(5),
            
            child:  Column(
              // 对齐方式 左对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 标题
                Row(
                  children: <Widget>[
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                       ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: item["key"]  == ""  ? Colors.white : Colors.orange
                          
                        ),
                        padding: EdgeInsets.only(left: 4,right: 4),
                        child: Text(
                        item["key"],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      ),
                  ],
                ),
              // 副标题
              Text(
                item['subtitle'],
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              )
            ],
          ),
          ),
          Container(
            // 右侧图片
            padding: EdgeInsets.only(right: 10),
            child:  Image.network(
              item['imageUrl'],
              width: 60,
              fit: BoxFit.fill,
            ),
          )
         
        ],
      ),
      ),
    );
  }



 // 底部视图
  Widget _starViewItem(BuildContext context, item) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: InkWell(
    
      onTap: () {
        /// 点击对应的item
        print(item['title']);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            item['title'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          // 标题
          Text(
            item['subtitle'],
            style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold,),
          ),
          Image.network(item['imageUrl'])
              
        ],

      ),
    ),
    );
  }