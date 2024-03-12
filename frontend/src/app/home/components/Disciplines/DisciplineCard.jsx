import React from 'react';
import { Link } from 'react-router-dom'; // Importando o Link do react-router-dom
import styles from './DisciplineCard.module.css';

const DisciplineLink = ({ to, children }) => (
  <Link to={to} className={styles.card}> 
    {children}
  </Link>
);

const DisciplineCard = ({ discipline }) => {
  return (
    <DisciplineLink to={`/edit-discipline/${discipline.code}`}>
      <h3>{discipline.name} - {discipline.code}</h3>
      <p>{discipline.department}</p>
      <p><strong>Semestre:</strong> {discipline.semester}</p>
      <p><strong>Professor:</strong> {discipline.professor}</p>
      <p>{discipline.description}</p>
    </DisciplineLink>
  );
};

export default DisciplineCard;
