import './repositories.dart';

class AppRepo {
  static final authRepository = AuthRepository();
  static final ordersReposistory = OrdersRepository();
  static final salesTypeRepository = SalesTypeRepo();
  static final discTypeRepository = DiscountTypeRepo();
  // static final cartRepository = CartRepo();
  // static final customerRepository = CustomerRepo();
  // static final orderRepository = OrderRepo();
  // static final customerTypeRepository = CustomerTypeRepo();
  // static final checkOutRepository = CheckOutRepo();
  // static final phLocationRepository = PhLocationRepo();

  Future<void> init() async {
    await salesTypeRepository.fetchFromAPI();
    await discTypeRepository.fetchDiscType();
    // await productsRepository.fetchProducts();
    // await customerRepository.fetchCustomerFromAPI();
    // await customerTypeRepository.fetchCustomerType();
    // // await phLocationRepository.fetchProvinces();
  }
}
