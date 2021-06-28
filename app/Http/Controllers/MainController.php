<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Material;
use App\Models\Product;
use App\Models\ProductMaterial;
use App\Models\Warehouse;

class MainController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {

        $warehouse = Warehouse::all();

        foreach ($request->products as $key => $massive)
        {

            $product[$key] = ['id' => $massive['product_id'], 'product_qty' => $massive['quantity'], 'product_name' => Product::find($massive['product_id']) ['product_name']];
            $cache = ProductMaterial::where('product_id', $product[$key]['id'])->get();

            //product to'liq mahsulotga ega bo'lgandan keyin keyingi product ga o'tish
            loop1:
                foreach ($cache as $key1 => $values)
                {
                    $material_id = $values->material_id;
                    $quantity = ($product[$key]['product_qty'] * $values->quantity);

                    //product uchun materiallarni keyingi warehouse dan qidirish
                    loop2:
                        $get = $warehouse->where('material_id', $material_id);

                        if (count($get) > 0)
                        {
                            foreach ($get as $key2 => $wh)
                            {

                                if ($wh->remainder >= $quantity)
                                {
                                    $product[$key]['product_materials'][] = ["warehouse_id" => $wh->id, "material_name" => Material::find($wh->material_id) ['material_name'], "qty" => $quantity, "price" => $wh->price, ];
                                    
                                    //elementlani collection dan o'chirish/remainder dan minus qilish
                                    foreach ($warehouse as $key3 => $value)
                                    {
                                        if ($value->id == $wh->id)
                                        {
                                            if ($wh->remainder == $quantity)
                                            {
                                                unset($warehouse[$key3]);
                                            }
                                            elseif ($wh->remainder > $quantity)
                                            {
                                                $warehouse[$key3]['remainder'] = ($warehouse[$key3]['remainder'] - $quantity);
                                                unset($cache[$key1]);
                                            }
                                        }
                                    }
                                    goto loop1;

                                }
                                else
                                {
                                    $product[$key]['product_materials'][] = ["warehouse_id" => $wh->id, "material_name" => Material::find($wh->material_id) ['material_name'], "qty" => $get[$key2]['remainder'], "price" => $wh->price, ];

                                    $quantity = $quantity - $get[$key2]['remainder'];

                                    //collection dan elementni olib tashlash
                                    foreach ($warehouse as $key3 => $value)
                                    {
                                        if ($value->id == $wh->id)
                                        {
                                            unset($warehouse[$key3]);
                                        }
                                    }
                                    goto loop2;
                                }
                            }
                        }
                        else
                        {
                            $product[$key]['product_materials'][] = ["warehouse_id" => null, "material_name" => Material::find($material_id) ['material_name'], "qty" => $quantity, "price" => null, ];
                            unset($cache[$key1]);
                        }
            }
        }

        return response()->json(['result' => $product]);
    }
}