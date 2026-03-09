import '../models/estimate.dart';
import '../models/estimate_item.dart';
import '../models/detail_item.dart';

/// 앱에서 사용할 견적서 샘플 데이터 (우림 종로.xlsx 형태 기준)
class SampleEstimates {
  static List<Estimate> get list => [
        _sampleUrimJongro(),
        _sample2(),
        _sample3(),
      ];

  /// 내역서 항목 추천용 초기 데이터 (우림 종로 내역)
  static List<DetailItem> get urimJongroDetailItems =>
      _sampleUrimJongro().detailItems;

  /// 우림 건설 종로현장 - 우림 종로.xlsx 형태
  static Estimate _sampleUrimJongro() {
    final e = Estimate(
      projectName: '우림 건설 종로현장',
      estimateDate: DateTime.now().subtract(const Duration(days: 3)),
      companyInfo: CompanyInfo(
        name: '대운공조시스템',
        address: '경기도하남시 감이남로66-2',
        phone: '02-483-4148',
        fax: '02-483-4147',
        mobile: '010-5484-3312',
        email: 'hituch@nate.com',
        bankAccount: '농협: 204075-51-058369 김영필',
      ),
      items: [
        EstimateItem(
          productName: '1.2.3 싱글형 매립덕트공사 삼성',
          specification: '식',
          unit: '식',
          quantity: 1,
          unitPrice: 18561200,
          note: '',
        ),
      ],
      detailItems: [
        DetailItem(no: 1, productName: 'DVM S ECO실외기', specification: 'AM040BXMDHH1', unit: 'EA', quantity: 3, materialUnitPrice: 1457500, laborUnitPrice: 0, note: ''),
        DetailItem(no: 2, productName: 'DVM S 고정압 덕트', specification: 'AM110ANHDBH1', unit: 'EA', quantity: 3, materialUnitPrice: 732600, laborUnitPrice: 0, note: ''),
        DetailItem(no: 3, productName: '유선리모컨', specification: 'AWR-WE13N', unit: 'EA', quantity: 3, materialUnitPrice: 42900, laborUnitPrice: 0, note: ''),
        DetailItem(no: 4, productName: '덕트 드레인 펌프', specification: 'ADP-G075SPK1D', unit: 'EA', quantity: 3, materialUnitPrice: 81400, laborUnitPrice: 0, note: ''),
        DetailItem(no: 5, productName: '유연호스 크램프', specification: '', unit: 'EA', quantity: 3, materialUnitPrice: 11000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 6, productName: '실외기 받침대', specification: '', unit: 'EA', quantity: 3, materialUnitPrice: 0, laborUnitPrice: 0, note: ''),
        DetailItem(no: 7, productName: '배관공사', specification: '15 9', unit: 'M', quantity: 150, materialUnitPrice: 40000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 8, productName: '실내기 설치공사', specification: '', unit: 'EA', quantity: 3, materialUnitPrice: 750000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 9, productName: '실외기 설치공사', specification: '시운전,냉매 충진', unit: 'EA', quantity: 3, materialUnitPrice: 180000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 10, productName: '드레인공사', specification: '', unit: '식', quantity: 1, materialUnitPrice: 850000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 11, productName: '흡입챔버', specification: '', unit: 'EA', quantity: 3, materialUnitPrice: 210000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 12, productName: '토출챔버', specification: '', unit: 'EA', quantity: 3, materialUnitPrice: 210000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 13, productName: '흡입그릴', specification: '', unit: 'EA', quantity: 3, materialUnitPrice: 45000, laborUnitPrice: 0, note: ''),
        DetailItem(no: 14, productName: '후렉시볼,디퓾져  별도견적', specification: '', unit: 'EA', quantity: 0, materialUnitPrice: 0, laborUnitPrice: 0, note: '별도견적'),
        DetailItem(no: 15, productName: '기타 잡자재', specification: '', unit: '식', quantity: 1, materialUnitPrice: 550000, laborUnitPrice: 0, note: ''),
      ],
      validityPeriod: '견적일로 부터 15일',
      deliveryPlace: '추후협의',
      deliveryDate: '추후협의',
      paymentTerms: '추후협의 : 계약금30%중도금60%시운전완료후10%',
      notes: [
        '반입, 설치 및 시운전 포함',
        '(1, 2차 전기공사 제외)- 발주처 시공조건',
        '천장마감이 텍스가 아닌경우 점검구 별도임.',
        '기타 견적외 사항은 별도임.',
      ],
      includeVat: false,
    );
    return e;
  }

  static Estimate _sample2() {
    final e = Estimate(
      projectName: '삼성 멀티에어컨 설치 - B동 회의실',
      estimateDate: DateTime.now().subtract(const Duration(days: 12)),
      items: [
        EstimateItem(
          productName: '멀티 실내기',
          specification: 'AR12T5140HZ (1.5마력)',
          unit: '대',
          quantity: 4,
          unitPrice: 420000,
          note: '카세트 2구',
        ),
        EstimateItem(
          productName: '멀티 실외기',
          specification: 'AR36T5140HZ (6마력)',
          unit: '대',
          quantity: 1,
          unitPrice: 2850000,
          note: '4실 연결',
        ),
        EstimateItem(
          productName: '설치 및 시운전',
          specification: '배관 15m 이내',
          unit: '식',
          quantity: 1,
          unitPrice: 1200000,
          note: '',
        ),
      ],
      detailItems: [
        DetailItem(no: 1, productName: '카세트 실내기', specification: 'AR12T5140HZ', unit: '대', quantity: 4, materialUnitPrice: 380000, laborUnitPrice: 40000, note: '2구'),
        DetailItem(no: 2, productName: '멀티 실외기', specification: 'AR36T5140HZ', unit: '대', quantity: 1, materialUnitPrice: 2650000, laborUnitPrice: 200000, note: '6마력'),
      ],
      validityPeriod: '견적일로 부터 20일',
      deliveryPlace: '추후협의',
      deliveryDate: '추후협의',
      paymentTerms: '계약금 30% 중도금 60% 시운전완료후 10%',
      includeVat: true,
    );
    return e;
  }

  static Estimate _sample3() {
    final e = Estimate(
      projectName: '일반 스탠드 에어컨 교체 공사',
      estimateDate: DateTime.now().subtract(const Duration(days: 2)),
      items: [
        EstimateItem(
          productName: '스탠드형 에어컨',
          specification: 'LW-D2511ES (10평형)',
          unit: '대',
          quantity: 1,
          unitPrice: 1650000,
          note: '전기포함',
        ),
        EstimateItem(
          productName: '철거 및 설치',
          specification: '기존기 철거 포함',
          unit: '식',
          quantity: 1,
          unitPrice: 350000,
          note: '',
        ),
      ],
      detailItems: [],
      validityPeriod: '견적일로 부터 15일',
      deliveryPlace: '현장',
      deliveryDate: '계약후 7일',
      paymentTerms: '현금 결제',
      includeVat: false,
    );
    return e;
  }
}
