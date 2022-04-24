import './repositories.dart';

class AppRepo {
  static final authRepository = AuthRepository();
  static final ordersReposistory = OrdersRepository();
  static final salesTypeRepository = SalesTypeRepo();
  static final discTypeRepository = DiscountTypeRepo();
  static final whseRepository = WarehouseRepo();
  static final salesRepository = SalesRepo();
  static final customersRepository = CustomersRepo();
  static final customerTypeRepository = CustomerTypesRepo();
  static final phLocationRepository = PhLocationRepo();
  // static final cartRepository = CartRepo();
  // static final orderRepository = OrderRepo();
  // static final checkOutRepository = CheckOutRepo();

  Future<void> init() async {
    await salesTypeRepository.fetchFromAPI();
    await discTypeRepository.fetchDiscType();
    await whseRepository.fetchWarehouses({"is_active": 1});
    await customerTypeRepository.getAllCustomerType();
    await customersRepository.fetchAllCustomers();
    // await productsRepository.fetchProducts();
    // await customerTypeRepository.fetchCustomerType();
    // // await phLocationRepository.fetchProvinces();
  }
}
