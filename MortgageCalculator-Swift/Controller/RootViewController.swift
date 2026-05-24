//
//  RootViewController.swift
//  MortgageCalculator-Swift
//

import UIKit
import SnapKit
import StoreKit
import GoogleMobileAds

class RootViewController: UIViewController {

    var rootSegmentedVC : UISegmentedControl?
    var commerciaiLoansVC : CommercialLoansTableViewController?
    var accumulationLoansVC : AccumulationFundTableViewController?
    var combinationLoansVC : CombinationLoabsTableViewController?
    var prepaymentVC : PrepaymentCalculatorViewController?
    var bannerView: GADBannerView!

    var loanCacheModel : LoanCacheManage?

    // MARK: - Title
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "房贷计算器"
        label.font = XZClient.XZFont3(size: 20)
        label.textColor = UIColor(named: "ic_theme")
        label.textAlignment = .left
        return label
    }()

    let rightBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ic_More"), for: .normal)
        return btn
    }()

    let myLoanInfoView:MyLoanInfoView = {
        let view = MyLoanInfoView()
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UserDefaults.standard.getCustomObject(forKey: "kTMCacheLoanManage") as? LoanCacheManage != nil {

            self.loanCacheModel = UserDefaults.standard.getCustomObject(forKey: "kTMCacheLoanManage") as? LoanCacheManage

            if self.loanCacheModel?.startPaymentStr?.Lenght == 8 {

                let dfmatter = DateFormatter()
                dfmatter.dateFormat="yyyyMMdd"

                let dayStr = dfmatter.date(from:(self.loanCacheModel?.startPaymentStr)!)

                let gregorians = Calendar(identifier: .gregorian)

                let result = gregorians.compare(Date(), to: dayStr!, toGranularity: .month)

                if result.rawValue == 1 {

                    let monthNumbers = gregorians.dateComponents([.year, .month, .hour], from: dayStr!, to: Date())

                    self.loanCacheModel?.alsoNumberMonthStr =
                    String(monthNumbers.month! + 12 * monthNumbers.year! + 1 )

                }else{

                    self.loanCacheModel?.alsoNumberMonthStr = "0"

                }

                myLoanInfoView.bind(model: self.loanCacheModel)

                pushMessage()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        #if DEBUG
        #else
        bannerView = GADBannerView(frame: CGRect(
            x: 0,
            y: XZClient.ScreenHeight() - (XZClient.XZiPhoneX() ? 150 : 100),
            width: XZClient.ScreenWidth(),
            height: 50
        ))

        bannerView.adSize = GADAdSizeBanner
        bannerView.center.x = self.view.center.x
        bannerView.adUnitID = "ca-app-pub-9353975206269682/6008483340"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        self.view.addSubview(bannerView)
        self.view.bringSubviewToFront(bannerView)
        #endif

        self.view.backgroundColor = XZSwiftColor.convenientBackgroundColor
        self.navigationController?.navigationBar.isTranslucent = false

        rightBtn.addTarget(self,action:#selector(right),for:.touchUpInside)

        self.view.addSubview(myLoanInfoView)

        myLoanInfoView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(145)
        }

        myLoanInfoView.bind(model: self.loanCacheModel)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addMyLoanInfoViewTap))

        myLoanInfoView.addGestureRecognizer(tapGestureRecognizer)

        rootSegmentedVC = UISegmentedControl(items: ["商业贷款","公积金贷款","组合贷款","提前还款"])

        rootSegmentedVC?.tintColor = XZSwiftColor.xzGlay50

        rootSegmentedVC?.setTitleTextAttributes(
            [.font:XZClient.XZFont2(size: 15)],
            for: .normal
        )

        self.view.addSubview(rootSegmentedVC!)

        rootSegmentedVC?.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(150)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(40)
        }

        rootSegmentedVC?.selectedSegmentIndex = 0

        rootSegmentedVC?.addTarget(
            self,
            action: #selector(segmentDidchange),
            for: .valueChanged
        )

        segmentDidchange(segmented: rootSegmentedVC!)

        SKStoreReviewController.requestReview()
    }

    // MARK: - NavigationBar
    func setupNavigationBar() {

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))

        container.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        navigationItem.titleView = container

        navigationItem.rightBarButtonItem =
        UIBarButtonItem(customView: rightBtn)

        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }

    // MARK: - Segment
    @objc func segmentDidchange(segmented:UISegmentedControl){

        if segmented.selectedSegmentIndex == 0 {

            if commerciaiLoansVC == nil {

                commerciaiLoansVC = CommercialLoansTableViewController()

                commerciaiLoansVC?.rootNavigationController =
                self.navigationController as? XZSwiftNavigationController

                self.view.addSubview(commerciaiLoansVC!.view)

                commerciaiLoansVC?.view.snp.makeConstraints { make in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                }
            }

            self.view.addSubview(commerciaiLoansVC!.view)

        }else if segmented.selectedSegmentIndex == 1 {

            if accumulationLoansVC == nil {

                accumulationLoansVC = AccumulationFundTableViewController()

                accumulationLoansVC?.rootNavigationController =
                self.navigationController as? XZSwiftNavigationController

                self.view.addSubview(accumulationLoansVC!.view)

                accumulationLoansVC?.view.snp.makeConstraints { make in
                    make.left.right.bottom.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                }
            }

            self.view.addSubview(accumulationLoansVC!.view)

        }else if segmented.selectedSegmentIndex == 2 {

            if combinationLoansVC == nil {

                combinationLoansVC = CombinationLoabsTableViewController()

                combinationLoansVC?.rootNavigationController =
                self.navigationController as? XZSwiftNavigationController

                self.view.addSubview(combinationLoansVC!.view)

                combinationLoansVC?.view.snp.makeConstraints { make in
                    make.left.right.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(15)
                    make.bottom.equalTo(self.view).offset(-64)
                }
            }

            self.view.addSubview(combinationLoansVC!.view)

        }else if segmented.selectedSegmentIndex == 3 {

            if prepaymentVC == nil {
                prepaymentVC = PrepaymentCalculatorViewController()
                self.addChild(prepaymentVC!)
                self.view.addSubview(prepaymentVC!.view)
                prepaymentVC!.view.snp.makeConstraints { make in
                    make.left.right.equalTo(self.view)
                    make.top.equalTo((self.rootSegmentedVC?.snp.bottom)!).offset(0)
                    make.bottom.equalTo(self.view).offset(-64)
                }
                prepaymentVC!.didMove(toParent: self)
            }

            self.view.addSubview(prepaymentVC!.view)

        }

        #if DEBUG
        #else
        self.view.bringSubviewToFront(bannerView)
        #endif
    }

}

extension RootViewController {

    @objc func right() {

        let rect = rightBtn.superview!.convert(rightBtn.frame, to: nil)
        YBPopupMenu.show(
            at: CGPoint(x: rect.midX, y: rect.maxY + 10),
            titles: ["添加","利率","更多"],
            icons: ["ic_AddInfo","ic_lilv","ic_MoreInfo"],
            menuWidth: 120
        ) { popupMenu in

            popupMenu?.priorityDirection = .bottom
            popupMenu?.dismissOnSelected = true
            popupMenu?.delegate = self
            popupMenu?.type = .dark
            popupMenu?.fontSize = 16
            popupMenu?.textColor = UIColor.white
            popupMenu?.itemHeight = 60
        }
    }

    @objc func addMyLoanInfoViewTap() {

        if loanCacheModel != nil {

            let editorVC = RemindTableViewController()

            editorVC.hidesBottomBarWhenPushed = true

            navigationController?.pushViewController(editorVC, animated: true)

        }else{

            navigationController?.pushViewController(
                RemindEditorViewController(),
                animated: true
            )
        }
    }

}

extension RootViewController:YBPopupMenuDelegate {

    func ybPopupMenuDidSelected(at index: Int, ybPopupMenu: YBPopupMenu!) {

        if index == 0 {

            navigationController?.pushViewController(
                RemindEditorViewController(),
                animated: true
            )

        }else if index == 1 {

            navigationController?.pushViewController(
                RateTableViewController(),
                animated: true
            )

        }else{

            navigationController?.pushViewController(
                UserViewController(),
                animated: true
            )
        }
    }
}

extension RootViewController {

    func pushMessage() {

        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        var components = DateComponents()

        components.day =
        Int((self.loanCacheModel?.repaymentDateStr)!)! - 1

        components.hour = 9
        components.minute = 30

        let content = UNMutableNotificationContent()

        content.userInfo = [
            "id": "1",
            "title": "房贷还款提醒",
            "body":"贷友：明天是您的还款日，请及时查询还款账号是否有money,以免影响您征信哦！"
        ]

        content.sound = UNNotificationSound.default

        content.body =
        "贷友：明天是您的还款日，请及时查询还款账号是否有money,以免影响您征信哦！"

        let trigger =
        UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request =
        UNNotificationRequest(
            identifier:"YongYiFangDai",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}
