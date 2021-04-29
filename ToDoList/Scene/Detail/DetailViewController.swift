//
//  DetailViewController.swift
//  GetirTodo
//
//  Created by Talip Böke on 20.04.2021.
//

import UIKit

internal final class DetailViewController: UIViewController {
    
    private(set) internal lazy var detailView = DetailView()
    internal lazy var saveButton = UIBarButtonItem(barButtonSystemItem: viewModel.saveButtonType, target: self, action: #selector(didTapSaveButton))
    private var viewModel: DetailViewModel
    internal var saveCompleted: (() -> Void)?
    
    internal init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = saveButton
        bind()
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
}

private extension DetailViewController {
    func bind() {
        detailView.titleTextField.text = viewModel.todo.title
        detailView.contentTextView.text = viewModel.todo.content
    }
    
    @objc
    func didTapSaveButton() {
        #warning("Validate must handle for empty string and Input validator Can be created and inject to this class")
        viewModel.todo.title = detailView.titleTextField.text!
        viewModel.todo.content = detailView.contentTextView.text
        viewModel.save { [weak self] in
            self?.saveCompleted?()
        } failure: { (error) in
            #warning("Handle Error")
        }
    }
}
