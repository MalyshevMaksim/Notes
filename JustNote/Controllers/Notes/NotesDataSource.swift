//
//  NotesDataSource.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

extension NotesViewController {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Int>
    typealias DataSource = UITableViewDiffableDataSource<Int, Int>
    
    func configureDataSource() {
        dataSource = DataSource(tableView: tableView) {
            (tableView, indexPath, Identifier) -> UITableViewCell? in
            
            return self.makeCell(with: Note(title: "How programming on Swift?", text: "Let me explain something about me, I’m IOS Developer about 4 years. When i try to build my first app i use storyboards, xib after that I convert my self into create everything programmatically. I’m not say this is the best way or only way but i prefer to continue like this. When i create something programmatically I feel like free as possible as be. So this is my first Medium story and sorry if I do something wrong.", tag: "123"), indexPath: indexPath)
        }
        dataSource.apply(makeSnapshot(), animatingDifferences: true)
    }
    
    private func makeCell(with note: Note, indexPath: IndexPath) -> NoteCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Unable to dequeue")
        }
        cell.configure(with: note)
        return cell
    }
    
    private func makeSnapshot() -> DataSourceSnapshot {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        snapshot.appendSections([1])
        snapshot.appendSections([2])
        snapshot.appendSections([3])
        
        for item in 0..<2 {
            snapshot.appendItems([item], toSection: 1)
        }
        
        for item in 2..<5 {
            snapshot.appendItems([item], toSection: 2)
        }
        
        for item in 5..<7 {
            snapshot.appendItems([item], toSection: 3)
        }
        return snapshot
    }
}
